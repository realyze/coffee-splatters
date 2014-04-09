require('coffee-script/register');
var path = require('path');

require("fs").readdirSync(path.join(__dirname, 'lib')).forEach(function(file) {
  if (~file.split('.').indexOf('spec')) {
    return;
  }
  file = path.basename(file, '.js');
  file = path.basename(file, '.coffee');
  module.exports[file] = require('./lib/' + file);
});
