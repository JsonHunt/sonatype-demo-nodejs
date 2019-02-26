converter = require './english-converter'

number = process.argv[2]
try
  console.log "Translating #{number}"
  text = converter.translate(number)
  console.log text
catch e
  console.log e.message
