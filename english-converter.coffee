words = require './words'

capitalize = (str)-> str.substr(0,1).toUpperCase() + str.substr(1)
peekStart = (str, howMany)-> str.substr 0, howMany
removeStart = (str, howMany)-> str.substr howMany
peekEnd = (str, howMany)-> str.substr -howMany
removeEnd = (str, howMany)-> str.substr 0, str.length-howMany

module.exports =
  addSpace: (str)-> if (str.length > 0) and (str[str.length-1] isnt ' ') then return str + ' ' else return str
  validateInteger: (str)-> /^-?\d+$/.test str
  translatePart: (part, useAnd)->
    while part[0] is '0'
      part = removeStart(part, 1)
    text = ""
    if part.length is 3
      hun = parseInt part[0]
      part = removeStart(part, 1)

    if part.length is 2
      tens = parseInt(part[0])
      if tens is 1
        tens = parseInt(part)
        part = removeStart(part, 2)
      else
        tens *= 10
        part = removeStart(part, 1)

    if part.length is 1
        ones = parseInt(part[0])

    hasAnd = useAnd and (tens or ones)

    if hun
      text += words[hun] + ' ' + words[100]

    if hasAnd
      text = @addSpace(text) + 'and'

    if tens
      text = @addSpace(text) + words[tens]

    if ones
      text = @addSpace(text) + words[ones]

    return text

  getParts: (str)->
    parts = []
    while str.length > 2
      parts.push peekEnd(str,3)
      str = removeEnd(str,3)
    if str.length > 0
      parts.push str
    parts.reverse()
    parts

  translate: (number)->
    text = ""
    if (number is undefined) or (number.length is 0)
      throw new Error("Missing parameter. Integer is required")
    isValid = @validateInteger number
    if !isValid
      throw new Error('Invalid parameter. Only integers are allowed')
    else
      if number.indexOf("-") is 0
        isNegative = true
        number = number.substr(1)
      parts = @getParts(number)
      while parts.length > 0
        useAnd = parts.length is 1
        text += @translatePart parts[0], useAnd
        parts.shift()
        if parts.length > 0
          text += ' ' + words.bigNumbers[parts.length] + ' '

      if isNegative
        text = words['-'] + ' ' + text
      return capitalize text.trim()
