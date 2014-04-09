describe "interpolate", ->

  interpolate = require './interpolate'

  it.only "should interpolate the object properties", ->
    obj =
      foo:
        bar: "{{foo.target}}"
        target: 42
        arr: [
          "{{foo.arr[1]}}"
          '84'
        ]
      yoohoo: "{{foo.bar}}"

    interpolate(obj).should.eql
      foo:
        bar: 42
        target: 42
        arr: ['84', '84']
      yoohoo: 42
  
  it "should throw when there's a circular interpolation", ->
    obj = foo:
      bar: '{{foo.bah}}'
      bah: '{{foo.baz.blah}}'
      baz:
        blah: '{{foo.bar}}'
    ( -> interpolate(obj)).should.throw()
