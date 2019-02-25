assert = require 'assert'
converter = require '../english-converter'

describe 'English number translator', ->
  it 'should translate zero', ->
    assert.equal converter.translate(0), 'zero'
