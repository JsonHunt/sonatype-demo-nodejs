// Generated by CoffeeScript 2.3.2
(function() {
  var converter, e, number, text;

  converter = require('./english-converter');

  number = process.argv[2];

  try {
    number = number != null ? number.replace(/'/g, '') : void 0;
    console.log(`Translating ${number}`);
    text = converter.translate(number);
    console.log(text);
  } catch (error) {
    e = error;
    console.log(e.message);
  }

}).call(this);
