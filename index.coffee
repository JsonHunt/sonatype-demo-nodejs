converter = require './english-converter'

number = process.argv[2]
try
  text = converter.translate(number)
  console.log text
catch e
  console.log "Invalid input. Only integers are allowed"
  console.log e.message
