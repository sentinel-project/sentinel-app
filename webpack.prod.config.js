var webpack = require('webpack');
var config = require("./webpack.config.js");

config.plugins = config.plugins.concat([
  // keeps hashes consistent between compilations
  new webpack.optimize.OccurenceOrderPlugin(),

  // minifies your code
  new webpack.optimize.UglifyJsPlugin({
    compressor: {
      warnings: true
    }
  })
]);

module.exports = config;
