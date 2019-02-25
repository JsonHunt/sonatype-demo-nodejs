words = require './words'

capitalize = (str)-> str.substr(0,1).toUpperCase() + str.substr(1)

module.exports =
  validateInteger: (str)-> /^-?\d*$/.test str
  translate: (number)->
    isValid = @validateInteger number
    if isValid
      return capitalize words[parseInt(number)]
    else
      throw new Error()
