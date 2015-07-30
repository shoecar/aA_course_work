var TicTacToe = require("./index");

var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new TicTacToe.Game(reader);
game.run(function (winner) {
  console.log("Yay! " + winner + " won!");
  reader.close();
}, ["x", "o"]);
