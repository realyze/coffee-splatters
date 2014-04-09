chai = require 'chai'
should = chai.should()

describe "deep", ->

  deep = require './deep'

  describe "getting a value", ->

    it "should return the value at `path` when passed an object", ->
      obj =
        sir:
          stop: "where"
        you: ["are", "right", now: "please"]
        and: [
          gimme:
            all:
              your: "money"
          aye: 42
        ]
      deep(obj, 'sir').should.eql stop: "where"
      deep(obj, 'sir.stop').should.equal "where"
      deep(obj, 'you').should.eql ['are', 'right', now: 'please']
      deep(obj, 'you[1]').should.equal 'right'
      deep(obj, 'you[2].now').should.equal 'please'
      deep(obj, 'and[0].gimme.all.your').should.equal 'money'


    it "should return the value at `path` when passed an array", ->
      obj = [foo: 'bar']
      deep(obj, '0.foo').should.equal 'bar'


    it "should throw an error when called on a non-object", ->
      (-> deep 42, 'foo').should.throw()
      (-> deep 'foo', 'foo').should.throw()
      (-> deep (->), 'foo').should.throw()

    it "should throw for an undefined path", ->
      obj = foo: bar: 'baz'
      (-> deep obj, 'foo.wtf.noooo').should.throw()

    it "should return `undefined` for a path ending with undefined key", ->
      obj = foo: bar: 'baz'
      should.not.exist (deep obj, 'foo.bar.wtf')


  describe "setting a value", ->

    it "should create the path when called path starts with `!`", ->
      obj = foo: bar: 42
      deep obj, '!foo.baz.bah', 84
      should.exist(obj.foo.baz.bah)
      obj.foo.baz.bah.should.equal 84

    it "should throw when setting an undefined path without `!`", ->
      obj = foo: bar: 42
      (-> deep(obj, 'foo.baz.bah', 84)).should.throw()

    it "should set the value at path", ->
      obj = foo: bar: 42

      deep(obj, 'foo.bar', 84)
      obj.foo.bar.should.equal 84

      deep(obj, 'foo.baz', [1, 2, 3])
      obj.foo.baz.should.eql [1, 2, 3]

      deep(obj, 'foo', 42)
      obj.foo.should.eql 42
