should = require('chai').should()

describe "list", ->

  list = require './list'

  it "should list all the paths in the object", ->
    obj = where:
      have: [1, 2, you: "been"]
      hm: "?"

    expected = [
      'where.have[0]'
      'where.have[1]'
      'where.have[2].you'
      'where.hm'
    ]
    list(obj).should.eql expected

  it "should not treat functions as objects", ->
    obj =
      foo: 42
      bar: (->)
    list(obj).should.eql ['foo', 'bar']

