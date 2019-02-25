words = require './words'

module.exports =
  translate: (number)->
    words[number]
