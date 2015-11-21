var d3 = require('d3');
var Datamap = require('datamaps/src/js/datamaps');
var queue = require('queue-async');
var _ = require("underscore");
var colorbrewer = require("colorbrewer");
var Rlite = require('rlite-router');

var margin = {top: 10, left: 10, bottom: 10, right: 10}
    , width = parseInt($('#world-map').width())
    , width = width - margin.left - margin.right
    , mapRatio = 3 / 2
    , height = width / mapRatio;

var worldMap, dataMap, centered, svg;

colorbrewer["Sentinel"] = {
    3: ["#B19DCA", "#5fad9f", "#FFF46C"],
    4: ["#B19DCA", "#5fad9f", "#FFF46C", "#584F92"]
};

function getColorScheme(name) {
    var scheme = colorbrewer[name];

    if (scheme === undefined) {
        scheme = colorbrewer['Blues'];
    }

    return scheme;
}

// =======================
// Load data from CSVs
// =======================
queue()
    .defer(d3.json, "/static/world-50m.json")
    .defer(d3.csv, "/countries.csv", cleanCSV)
    .await(function (error, json, countries) {
        updateProgressBar(75);
        d3.selectAll("#map-section .hidden").classed("hidden", false);
        setupMap(json);

        var data = {};
        countries.forEach(function (d) {
            data[d.id] = d.data;
        });
        dataMap = d3.map(data);
        updateProgressBar(90);
        init();
        hideProgressBar();
    });

function updateProgressBar(update) {
    var pbar = d3.select(".progress-bar");
    var valuenow = parseInt(pbar.attr("data-percent"));
    var value;
    if (!isNaN(update)) {
        value = update;
    } else if (update.add) {
        value = valuenow + update.add;
    } else {
        value = valuenow;
    }
    pbar.attr("data-percent", value)
        .transition().duration(300)
        .style("width", value + "%");
}

function hideProgressBar() {
    d3.select("#loading").classed("hidden", true);
}

var csvDown = false;

function cleanCSV(data) {
    if (!csvDown) {
        updateProgressBar(80);
        csvDown = true;
    }
    var numFields = [
        "mdr_estimated_cases",
        "mdr_eval_0",
        "mdr_eval_5",
        "mdr_treat_0",
        "mdr_treat_5",
        "mdr_therapy_0",
        "mdr_therapy_5",
        "reported_mdr",
        "reported_xdr",
        "documented_adult_mdr",
        "documented_child_mdr",
        "documented_adult_xdr",
        "documented_child_xdr"];
    var d = {};

    d["name"] = data["name"];
    _.each(numFields, function (field) {
        d[field] = +data[field];

        var textField = field + "_text";
        if (data[textField]) {
            d[textField] = data[textField];
        }
    });

    if (d["documented_child_mdr"] === 1) {
        d["pub_mdr"] = 3;
    } else if (d["documented_adult_mdr"] === 1) {
        d["pub_mdr"] = 2;
    } else {
        d["pub_mdr"] = d["reported_mdr"];
    }
    d["pub_mdr_text"] = data["pub_mdr_text"];

    if (d["documented_child_xdr"] === 1) {
        d["pub_xdr"] = 3;
    } else if (d["documented_adult_xdr"] === 1) {
        d["pub_xdr"] = 2;
    } else {
        d["pub_xdr"] = d["reported_xdr"];
    }
    d["pub_xdr_text"] = data["pub_xdr_text"];

    return {id: data["code"], data: d};
}


//// =================
//// Show initial map
//// =================

function setupMap(json) {
    d3.select('#world-map').style({"height": height + "px"});

    worldMap = new Datamap({
        element: document.getElementById("world-map")
        , scope: 'countries'
        , projection: 'mercator'
        , setProjection: setProjection
        , fills: fillsForScheme('Grays')
        , projectionConfig: {
            rotation: [-11, 0]
        }
        , geographyConfig: {
            dataJson: json,
            highlightOnHover: false,
            popupTemplate: function (geography, data) {
                return [
                    '<div class="hoverinfo"><strong>',
                    data ? data.countryName : geography.properties.name,
                    '</strong></div>'
                ].join('');
            }
        }
    });

    svg = d3.select("#world-map").select("svg");
    g = svg.select("g");

    var $worldMapDiv = $("#world-map");
    svg.attr('viewBox', '0 0 ' + $worldMapDiv.width() + " " + $worldMapDiv.height());
    d3.select(window).on('resize', resize);
}

function fillsForScheme(colorscheme) {
    var fills = {defaultFill: "#CCC"};
    _(getColorScheme(colorscheme)).each(function (colors, count) {
        _(colors).each(function (color, idx) {
            fills["q" + idx + "-" + count] = color;
        })
    });
    return fills;
}


//// =============================================
//// Set up map to display and resize correctly
//// =============================================


function resize() {
    // adjust things when the window size changes
    width = parseInt(d3.select('#world-map').style('width'));
    width = width - margin.left - margin.right;
    height = width / mapRatio;
    svg.attr('width', width).attr('height', height);

    worldMap.resize();
}


function setProjection(element, options) {
    var width = options.width || element.offsetWidth;
    var height = options.height || element.offsetHeight;
    var projection, path;

    projection = d3.geo[options.projection]()
        .scale((width + 1) / 2 / Math.PI)
        .translate([width / 2, height / (options.projection === "mercator" ? 1.45 : 1.8)])
        .rotate(options.projectionConfig.rotation);

    path = d3.geo.path()
        .projection(projection);

    return {path: path, projection: projection};
}

function generateLogLegend(segments) {
    var labels = ["0-9"];
    for (var i = 1; i < segments - 1; i++) {
        labels[i] = Math.pow(10, i).toLocaleString() + "-" + (Math.pow(10, i + 1) - 1).toLocaleString();
    }
    labels[i] = Math.pow(10, i).toLocaleString() + "+";
    return labels;
}

function updateMap(mapId) {
    uncenter();
    var mapDef = charts[mapId];
    var scale, segments, legendData, infoFn;

    $("#default-info").html(mapDef.defaultText);

    d3.selectAll(".map-list a").classed({"active": false});

    // This is easier to do with jQuery.
    var $mapLink = $("#link-" + mapId)
    $mapLink.addClass('active');
    var tabName = $mapLink.closest('.tab-pane').attr('id');
    $("a[href='#" + tabName + "']").tab('show');

    if (mapDef.scale === "log") {
        scale = d3.scale.log();
        segments = mapDef.segments;
        var colors = getColorScheme(mapDef.colorscheme)[segments + 1].slice(1);
        legendData = _(colors).zip(generateLogLegend(segments));
        infoFn = function (data) {
            return {
                "fillKey": fillKey(data[mapId]),
                "countryName": data.name,
                "description": data[mapId + "_text"] || d3.format(",d")(data[mapId])
            };
        }
    } else {
        segments = Math.max(mapDef.ordinals.length, 3);
        scale = d3.scale.linear();

        var colors = getColorScheme(mapDef.colorscheme)[segments];
        legendData = _(colors).zip(mapDef.ordinals);
        infoFn = function (data) {
            return {
                "fillKey": fillKey(data[mapId]),
                "countryName": data.name,
                "description": data[mapId + "_text"] || mapDef.ordinals[data[mapId]]
            }
        }
    }

    d3.select("#map-title").text(mapDef.title);

    var legend = d3.select('#legend');
    legend.selectAll("ul").remove();
    var list = legend.append('ul').classed('list-inline', true);
    var keys = list.selectAll('li.key').data(legendData);
    keys.enter()
        .append('li')
        .classed('key', true)
        .style('border-left-color', function (d) {
            return d[0]
        })
        .text(function (d) {
            return d[1];
        });

    var fillKey = function (i) {
        var max = segments;
        var fill = (i == 0) ? 0 : Math.min(Math.floor(scale(i)), max);

        if (mapDef.scale == "log") {
            max += 1;
            fill += 1;
        }

        return "q" + fill + "-" + max;
    };

    var newData = {};
    dataMap.forEach(function (code, d) {
        newData[code] = infoFn(d);
    });

    worldMap.options.fills = fillsForScheme(mapDef.colorscheme);
    worldMap.updateChoropleth(newData);
}

function zoom() {
    d3.event.stopPropagation();

    if (this === centered || this === svg.node()) {
        uncenter();
    } else {
        if (centered) {
            resetStyle(centered);
        }
        var path = d3.select(this);
        center(path);
    }
}

function resetStyle(element) {
    element = d3.select(element);
    var previousAttributes = JSON.parse(element.attr('data-previousAttributes'));
    element.style(previousAttributes);
}


function center(path) {
    if (centered) {
        resetStyle(centered);
    }

    centered = path.node();

    var g = svg.select("g"),
        gbox = g.node().getBBox(),
        bbox = path.node().getBBox(),
        spacing = 20,
        x = bbox.x - spacing,
        y = bbox.y - spacing,
        boxheight = Math.max(1, bbox.height + (2 * spacing)),
        boxwidth = Math.max(1, bbox.width + (2 * spacing)),
        gratio = gbox.width / gbox.height,
        scale = Math.min(gbox.height / boxheight, gbox.width / boxwidth),
        newheight = Math.max(boxheight, gratio / boxwidth),
        newwidth = Math.max(boxwidth, gratio * boxheight),
        dx = -x + (newwidth - boxwidth) / 2,
        dy = -y + (newheight - boxheight) / 2;

    // special case since the US wraps around
    if (path.classed("USA")) {
        x = 0;
        boxwidth = 404 + (2 * spacing);
        scale = Math.min(gbox.height / boxheight, gbox.width / boxwidth);
        newwidth = Math.max(boxwidth, gratio * boxheight);
        dx = -x + (newwidth - boxwidth) / 2;
    }

    g.transition().duration(750)
        .attr("transform", "scale(" + scale + ") " + "translate(" + dx + "," + dy + ")");
    svg.selectAll("path")
        .classed("centered", false)
        .style("stroke-width", 1 / scale);

    var previousAttributes = {
        'fill': path.style('fill'),
        'stroke': path.style('stroke'),
        'fill-opacity': path.style('fill-opacity')
    };

    path.attr('data-previousAttributes', JSON.stringify(previousAttributes))
        .style("fill", "#7F7F7F")
        .classed("centered", true);

    if (path.attr("data-info")) {
        d3.select("#country-info")
            .html(infoTemplate(JSON.parse(path.attr("data-info"))))
            .classed("hidden", false);
        d3.select("#default-info")
            .classed("hidden", true);
    }
}

var infoTemplate = function (data) {
    return "<h4>" + data.countryName + "</h4>" +
        "<div>" + data.description + "</div>";
}

function uncenter() {
    var g = svg.select("g");
    g.transition()
        .duration(750)
        .attr("transform", "");
    svg.selectAll("path")
        .style("stroke-width", 1);

    if (centered) {
        resetStyle(centered);
    }

    d3.select("#country-info").html("").classed("hidden", true);
    d3.select("#default-info").classed("hidden", false);
    d3.select("#country-select").node().value = "---";
    centered = null;
}


function init() {
    var r = Rlite();

    // Default route
    r.add('', function () {
        updateMap(window.defaultChart);
    });

    r.add('map/:name', function (r) {
        updateMap(r.params.name);
    });

    // Hash-based routing
    function processHash() {
        var hash = location.hash || '#';
        r.run(hash.slice(1));
    }

    window.addEventListener('hashchange', processHash);
    processHash();

    //// Set up zooming
    var g = svg.select("g");
    svg.on("click", zoom);
    g.selectAll("path").on("click", zoom);

    resize();

    var countries = dataMap.keys();
    var countryOptions = _.zip(countries, _.map(countries, function (cc) {
        return dataMap.get(cc)["name"];
    }));
    countryOptions = _.sortBy(countryOptions, function (d) {
        return d[1];
    });
    countryOptions = [["---", "Select country"]].concat(countryOptions)

    d3.select("#country-select").selectAll("option").data(countryOptions)
        .enter()
        .append('option')
        .attr("value", function (d) {
            return d[0];
        })
        .html(function (d) {
            return d[1];
        })

    d3.select("#country-select").on("change", function () {
        if (this.value === "---") {
            uncenter();
        } else {
            center(d3.select("." + this.value));
        }
    });
}
