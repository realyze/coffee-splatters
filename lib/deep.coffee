_ = require 'underscore'

# When called without `val`, returns the value at `path` (or throws an error if
# the path is invalid).
# When called with val, sets the value at `path` to `val`. If `path` begins
# with `!`, `path` is created if it doesn't exist (if it doesn't conflict with
# any existing path)
module.exports = (obj, path, val = null) ->
  if not _.isObject(obj) or _.isFunction(obj)
    throw new Error "Not an object."
  createPath = no
  if path[0] == '!'
    path = path[1..]
    createPath = yes
  arrayRegexp = /(.*)\[([0-9]+)\]/g
  parts = _.flatten _.map path.split('.'), (part) ->
    part.replace(arrayRegexp, '$1.$2').split '.'
  tmp = _.reduce _.initial(parts), (memo, part) ->
    if val and createPath and not memo[part]?
      memo[part] = {}
    memo[part]
  , obj
  if val then (tmp[_.last(parts)] = val) else tmp[_.last(parts)]
