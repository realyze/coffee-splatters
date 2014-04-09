_ = require 'underscore'

module.exports = (obj) ->
  _listPaths = (obj, paths, currentPath) ->
    if not _.isObject(obj) or _.isFunction(obj)
      paths.push currentPath
      return

    for key, val of obj
      path = null
      if not currentPath
        path = key
      else
        if _.isArray(obj)
          path = "#{currentPath}[#{key}]"
        else
          path = "#{currentPath}.#{key}"
      _listPaths val, paths, path

  paths = []
  _listPaths obj, paths
  return paths
