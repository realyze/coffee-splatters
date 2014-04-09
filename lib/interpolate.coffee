_ = require 'underscore'
list = require './list'
deep = require './deep'

module.exports = (obj, count = 10) ->
  firstSubRegExp = /(.*?){{(.+?)}}(.*)/
  paths = list(obj)

  for path in paths
    val = deep(obj, path)
    _count = count
    while val.match?(/.*{{.+}}.*/) and --_count > 0
      pointsTo = val.replace firstSubRegExp, '$2'
      if val.replace(firstSubRegExp, "$1$3")
        val = val.replace(firstSubRegExp, "$1#{deep(obj, pointsTo)}$3")
      else
        val = deep(obj, pointsTo)
      deep(obj, path, val)

    if _count == 0
      throw new Error("Circular interpolation detected.")

  return obj
