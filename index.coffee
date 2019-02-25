converter = require './english-converter'

number = process.argv[2]
text = converter.translate(number)
console.log text
