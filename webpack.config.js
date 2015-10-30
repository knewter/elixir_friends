var path = require('path')

module.exports = {
  context: __dirname,
  // devtool: 'cheap-eval-source-map',
  entry: {
    app: path.join(__dirname, 'web', 'static', 'js', 'app.js')
  },
  output: {
    path: path.join(__dirname, 'priv', 'static', 'js'),
    filename: "app.js"
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loaders: [ 'babel' ]
      },
      {
        test: /\.jsx$/,
        loaders: [ 'babel' ],
        exclude: /node_modules/
      },
      {
        test: /\.scss$/,
        loaders: [ 'style', 'css', 'autoprefixer', 'sass' ]
      }
    ]
  },
  resolve: {
    modulesDirectories: [
      'web/static',
      'deps/phoenix/web/static/js/',
      'node_modules'
    ],
    extensions: [ '', '.js', '.json', '.jsx', '.scss' ]
  }
}
