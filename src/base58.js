const Base58 = require("base58");

// MAX safe integer is 9007199254740991

str = "This is a big day";
int = 9007199254740991; // 6857269519
shrtnr = "brXijP";

shortner = Base58.int_to_base58(int); // 'brXijP'
num = Base58.base58_to_int(shrtnr); // 6857269519

console.log(shortner);
