assert = require 'assert'
converter = require '../english-converter'

describe 'English number translator', ->
  it 'should validate input', ->
    isValid =
    assert.equal converter.validateInteger('23.11'), false
    assert.equal converter.validateInteger(''), false
    assert.equal converter.validateInteger('0'), true
    assert.equal converter.validateInteger('-50'), true
    assert.equal converter.validateInteger('000x0!@'), false

  describe 'addSpace', ->
    it 'should only add space to non empty string without space at the end', ->
      assert.equal converter.addSpace(''), ''
      assert.equal converter.addSpace('test '), 'test '
      assert.equal converter.addSpace('test'), 'test '

  describe 'getParts', ->
    it 'should split string into three digit parts', ->
      parts = converter.getParts('945688764')
      assert.equal parts.length, 3
      assert.equal parts[0], '945'
      assert.equal parts[1], '688'
      assert.equal parts[2], '764'

    it 'should allow first part to be two digits', ->
      parts = converter.getParts('45688')
      assert.equal parts.length, 2
      assert.equal parts[0], '45'
      assert.equal parts[1], '688'

    it 'should allow first part to be one digit', ->
      parts = converter.getParts('4568')
      assert.equal parts.length, 2
      assert.equal parts[0], '4'
      assert.equal parts[1], '568'

  describe 'translatePart', ->
    it 'should ignore zero', ->
      assert.equal converter.translatePart('0'), ''

    it 'should translate irregular numbers < 20', ->
      assert.equal converter.translatePart('1'), 'one'
      assert.equal converter.translatePart('2'), 'two'
      assert.equal converter.translatePart('3'), 'three'
      assert.equal converter.translatePart('4'), 'four'
      assert.equal converter.translatePart('5'), 'five'
      assert.equal converter.translatePart('6'), 'six'
      assert.equal converter.translatePart('7'), 'seven'
      assert.equal converter.translatePart('8'), 'eight'
      assert.equal converter.translatePart('9'), 'nine'
      assert.equal converter.translatePart('10'), 'ten'
      assert.equal converter.translatePart('11'), 'eleven'
      assert.equal converter.translatePart('12'), 'twelve'
      assert.equal converter.translatePart('13'), 'thirteen'
      assert.equal converter.translatePart('14'), 'fourteen'
      assert.equal converter.translatePart('15'), 'fifteen'
      assert.equal converter.translatePart('16'), 'sixteen'
      assert.equal converter.translatePart('17'), 'seventeen'
      assert.equal converter.translatePart('18'), 'eighteen'
      assert.equal converter.translatePart('19'), 'nineteen'

    it 'should ignore leading zeroes', ->
      assert.equal converter.translatePart('019'), 'nineteen'
      assert.equal converter.translatePart('009'), 'nine'
      assert.equal converter.translatePart('000'), ''
      assert.equal converter.translatePart('000000000'), ''

    it 'should translate hundreds', ->
      useAnd = true
      assert.equal converter.translatePart('101', useAnd), 'one hundred and one'
      assert.equal converter.translatePart('111', useAnd), 'one hundred and eleven'
      assert.equal converter.translatePart('130', useAnd), 'one hundred and thirty'
      assert.equal converter.translatePart('135', useAnd), 'one hundred and thirty five'
      assert.equal converter.translatePart('500', useAnd), 'five hundred'

  describe 'translate', ->
    it 'should capitalize first letter', ->
      assert.equal converter.translate('101'), 'One hundred and one'

    it 'should add word "negative" if number has minus sign', ->
      assert.equal converter.translate('-53465'), 'Negative fifty three thousand four hundred and sixty five'

    it 'should join parts with correct numbers', ->
      assert.equal converter.translate('101000'), 'One hundred one thousand'
      assert.equal converter.translate('101001'), 'One hundred one thousand and one'
      assert.equal converter.translate('120567'), 'One hundred twenty thousand five hundred and sixty seven'
      assert.equal converter.translate('246012'), 'Two hundred forty six thousand and twelve'
      assert.equal converter.translate('56123456'), 'Fifty six million one hundred twenty three thousand four hundred and fifty six'
      assert.equal converter.translate('1001000'), 'One million one thousand'
      assert.equal converter.translate('1001001000'), 'One billion one million one thousand'
      assert.equal converter.translate('1001001001000'), 'One trillion one billion one million one thousand'
      assert.equal converter.translate('1001001001001000'), 'One quadrillion one trillion one billion one million one thousand'
