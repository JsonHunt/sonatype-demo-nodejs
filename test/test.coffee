assert = require 'assert'
converter = require '../english-converter'

describe 'English number translator', ->
  it 'should validate input', ->
    isValid =
    assert.equal converter.validateInteger('23.11'), false
    assert.equal converter.validateInteger('0'), true
    assert.equal converter.validateInteger('-50'), true
    assert.equal converter.validateInteger('000x0'), false

  it 'should translate zero', ->
    assert.equal converter.translate('0'), 'Zero'

  it 'should translate irregular numbers under 20', ->
    assert.equal converter.translate('1'), 'One'
    assert.equal converter.translate('2'), 'Two'
    assert.equal converter.translate('3'), 'Three'
    assert.equal converter.translate('4'), 'Four'
    assert.equal converter.translate('5'), 'Five'
    assert.equal converter.translate('6'), 'Six'
    assert.equal converter.translate('7'), 'Seven'
    assert.equal converter.translate('8'), 'Eight'
    assert.equal converter.translate('9'), 'Nine'
    assert.equal converter.translate('10'), 'Ten'
    assert.equal converter.translate('11'), 'Eleven'
    assert.equal converter.translate('12'), 'Twelve'
    assert.equal converter.translate('13'), 'Thirteen'
    assert.equal converter.translate('14'), 'Fourteen'
    assert.equal converter.translate('15'), 'Fifteen'
    assert.equal converter.translate('16'), 'Sixteen'
    assert.equal converter.translate('17'), 'Seventeen'
    assert.equal converter.translate('18'), 'Eighteen'
    assert.equal converter.translate('19'), 'Nineteen'

  it 'should ignore leading zeroes', ->
    assert.equal converter.translate('019'), 'Nineteen'
