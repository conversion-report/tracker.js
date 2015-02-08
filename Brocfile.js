var filterCoffeeScript = require('broccoli-coffee');
var replace            = require('broccoli-replace');
var env                = process.env.ENVIRONMENT;
env || (env = 'development');
var protocol, host;

switch (env) {
  case 'production':
    protocol = 'https'
    host = 'www.conversion.report'
  default:
    protocol = 'http'
    host = 'localhost:3000'
}

var tree = replace('lib', {
  files: [
    '*.coffee' // replace only html files in src
  ],
  patterns: [
    {
      match: 'PROTOCOL',
      replacement: protocol
    },
    {
      match: 'HOST',
      replacement: host
    }
  ]
})

module.exports = filterCoffeeScript(tree, { bare: false });
