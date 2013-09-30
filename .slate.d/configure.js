// parse a confiuration object with defaults
var configure = function(args, defaults) {
  return _.extend(defaults, args || {});
}
