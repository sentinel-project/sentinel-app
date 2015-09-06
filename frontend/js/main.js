var d3 = require('d3');
var topojson = require('topojson');
var Datamap = require('./datamaps.world');
var queue = require('queue-async');
var _ = require("underscore");
var colorbrewer = require("colorbrewer");
var Backbone = require('backbone');

var margin = {top: 10, left: 10, bottom: 10, right: 10}
    , width = parseInt(d3.select('#world-map').style('width'))
    , width = width - margin.left - margin.right
    , mapRatio = 1008 / 651
    , height = width / mapRatio;

var colorscheme = "Blues";

var fills = {defaultFill: "#CCC"};
_(colorbrewer[colorscheme]).each(function (colors, count) {
    _(colors).each(function (color, idx) {
        fills["q" + idx + "-" + count] = color;
    })
});

d3.select('#world-map')
    .style({
        "width": "100%",
        "height": height + "px"
    });

var worldMap = new Datamap({
    element: document.getElementById("world-map"),
    projection: 'mercator',
    setProjection: setProjection,
    fills: fills,
    projectionConfig: {
        rotation: [-10, 0]
    }
});

window.worldMap = worldMap;

function setProjection(element, options) {
    var width = options.width || element.offsetWidth;
    var height = options.height || element.offsetHeight;
    var projection, path;
    var svg = this.svg;

    options.scope = 'world';

    projection = d3.geo[options.projection]()
        .scale((width + 1) / 2 / Math.PI)
        .translate([width / 2, height / (options.projection === "mercator" ? 1.45 : 1.8)])
        .rotate(options.projectionConfig.rotation);

    path = d3.geo.path()
        .projection(projection);

    return {path: path, projection: projection};
}

var dataMap, centered;

// =======================
// Load data from CSVs
// =======================
queue()
    .defer(d3.csv, "/countries.csv", cleanCSV)
    .await(function (error, countries) {
        var data = {};
        countries.forEach(function (d) {
            data[d.id] = d.data;
        });
        dataMap = d3.map(data);
        init();
    });

function cleanCSV(data) {
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
    });

    d["reported"] = d["reported_mdr"] + 2 * d["reported_xdr"];
    d["pub_mdr"] = d["documented_adult_mdr"] + 2 * d["documented_child_mdr"];
    d["pub_xdr"] = d["documented_adult_mdr"] + 2 * d["documented_child_xdr"];

    if (d["documented_child_mdr"] === 1) {
        d["all_mdr"] = 3;
    } else if (d["documented_adult_mdr"] === 1) {
        d["all_mdr"] = 2;
    } else {
        d["all_mdr"] = d["reported_mdr"];
    }

    if (d["documented_child_xdr"] === 1) {
        d["all_xdr"] = 3;
    } else if (d["documented_adult_xdr"] === 1) {
        d["all_xdr"] = 2;
    } else {
        d["all_xdr"] = d["reported_xdr"];
    }

    return {id: data["code"], data: d};
}


//// =============================================
//// Set up map to display and resize correctly
//// =============================================
var worldMapContainer = d3.select("#world-map");
var svg = worldMapContainer.select("svg");
d3.select(window).on('resize', resize);


function resize() {
    // adjust things when the window size changes
    width = parseInt($('#world-map').width());
    width = width - margin.left - margin.right;
    height = width / mapRatio;

    var prefix = '-webkit-transform' in document.body.style ? '-webkit-' : '-moz-transform' in document.body.style ? '-moz-' : '-ms-transform' in document.body.style ? '-ms-' : '',
          newsize = width,
          oldsize = svg.attr('data-width');

    svg.selectAll('g').style(prefix + 'transform', 'scale(' + (newsize / oldsize) + ')');

    svg.attr('width', width).attr('height', height);

    $("#country-info").css("width", $("#side-menu").width());
}


//// =================
//// Show initial map
//// =================

function generateLogLegend(segments) {
    var labels = [];
    for (var i = 0; i < segments - 1; i++) {
        labels[i] = Math.pow(10, i).toLocaleString() + "-" + (Math.pow(10, i + 1) - 1).toLocaleString();
    }
    labels[i] = Math.pow(10, i).toLocaleString() + "+";
    return labels;
}

function updateMap(mapId) {
    console.log(mapId);
//    uncenter();
    var mapDef = charts[mapId];
    var scale, segments, legendData, tooltipFn, infoFn;

    d3.selectAll(".map-list a").classed({"active": false});

    // This is easier to do with jQuery.
    var $mapLink = $("#link-" + mapId)
    $mapLink.addClass('active');
    var tabName = $mapLink.closest('.tab-pane').attr('id');
    $("a[href='#" + tabName + "']").tab('show');

    if (mapDef.scale === "log") {
        scale = d3.scale.log();
        segments = mapDef.segments;
        var colors = colorbrewer[colorscheme][segments];
        legendData = _(colors).zip(generateLogLegend(segments));
        infoFn = function () {
            var data = dataMap.get(this.id);
            if (data !== undefined) {
                return "<div><strong>" + data.name + "</strong></div><div>" + d3.format(",d")(data[mapId]) + "</div>";
            }
        }
    } else {
        segments = mapDef.ordinals.length;
        scale = d3.scale.linear();

        var colors = colorbrewer[colorscheme][segments];
        legendData = _(colors).zip(mapDef.ordinals);
        infoFn = function () {
            var data = dataMap.get(this.id);
            if (data !== undefined) {
                return "<div><strong>" + data.name + "</strong></div><div>" + mapDef.ordinals[data[mapId]] + "</div>";
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
        if (i === 0) {
            return "q0-" + segments;
        }
        return "q" + Math.min(segments - 1, Math.floor(scale(i))) + "-" + segments;
    };

    var newData = {};
    dataMap.forEach(function (code, d) {
        newData[code] = {fillKey: fillKey(d[mapId])}
    });

    worldMap.updateChoropleth(newData);
}
//
//function zoom() {
//    d3.event.stopPropagation();
//
//    if (this === centered || this === svg.node()) {
//        uncenter();
//    } else {
//        var path = d3.select(this);
//        center(path);
//    }
//}
//
//
//function center(path) {
//    var g = svg.select("g"),
//        gbox = g.node().getBBox(),
//        bbox = path.node().getBBox(),
//        spacing = 20,
//        x = bbox.x - spacing,
//        y = bbox.y - spacing,
//        boxheight = bbox.height + (2 * spacing),
//        boxwidth = bbox.width + (2 * spacing),
//        gratio = gbox.width / gbox.height,
//        scale = Math.min(gbox.height / boxheight, gbox.width / boxwidth),
//        newheight = Math.max(boxheight, gratio / boxwidth),
//        newwidth = Math.max(boxwidth, gratio * boxheight),
//        dx = -x + (newwidth - boxwidth) / 2,
//        dy = -y + (newheight - boxheight) / 2;
//
//    g.transition().duration(750)
//        .attr("transform", "scale(" + scale + ")" + "translate(" + dx + "," + dy + ")")
//        .style("stroke-width", 1 / scale);
//    d3.selectAll(".land").classed("centered", false);
//    path.classed("centered", true);
//
//    d3.select("#country-info")
//        .html(path.attr("data-info"))
//        .classed("hidden", false);
//
//    centered = path.node();
//}
//
//function uncenter() {
//    var g = svg.select("g");
//
//    g.transition().duration(750).attr("transform", "").style("stroke-width", 1);
//    d3.select(centered).classed("centered", false);
//    d3.select("#country-info").html("").classed("hidden", true);
//    d3.select("#country-select").node().value = "---";
//    centered = null;
//}
//
function init() {
    var MapRouter = Backbone.Router.extend({
        routes: {
            "map/:mapName": "showMap"
        },

        showMap: function (mapName) {
            updateMap(mapName);
        }
    });

    var initialMap = "reported";
    updateMap(initialMap);

    //// Set up zooming
    //var g = svg.select("g");
    //svg.on("click", zoom);
    //g.selectAll("path.land").on("click", zoom);

    resize();

    var countries = dataMap.keys();
    console.log(countries);
    var countryOptions = _.zip(countries, _.map(countries, function (cc) {
        return dataMap.get(cc)["name"];
    }));
    countryOptions = _.sortBy(countryOptions, function (d) {
        return d[1];
    });
    countryOptions = [["---", "---"]].concat(countryOptions)

    d3.select("#country-select").selectAll("option").data(countryOptions)
        .enter()
        .append('option')
        .attr("value", function (d) {
            return d[0];
        })
        .html(function (d) {
            return d[1];
        })

    //d3.select("#country-select").on("change", function () {
    //    if (this.value === "---") {
    //        uncenter();
    //    } else {
    //        center(d3.select("#" + this.value));
    //    }
    //});

    var router = new MapRouter();
    Backbone.history.start();
}
