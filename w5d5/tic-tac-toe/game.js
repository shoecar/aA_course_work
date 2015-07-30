var Board = require("./board");

function Game(reader) {
  this.board = new Board();
  this.reader = reader;
}

Game.prototype.placeSym = function (row, col, sym) {
  if(this.board.isEmpty(row, col)) {
    this.board.grid[row][col] = sym;
    return true;
  } else {
    return false;
  }
}

Game.prototype.run = function (completionCallback, syms) {
  var move = this.placeSym.bind(this);
  var won = this.board.isWon.bind(this.board);
  // var tied = this.board.isTied.bind(this.board);
  var boundRun = this.run.bind(this);

  this.board.print();
  console.log("Player " + syms[0]);
  this.reader.question("Give row and col: ", function (pos) {
    var row = pos[0], col = pos[2];
    if(move(row, col, syms[0])) {
      if (won(syms[0])) {
        completionCallback(syms[0]);
      // } else if (tied()){
      //   completionCallback("nobody");
      } else {
        boundRun(completionCallback, syms.reverse());
      }
    }
  });
}

module.exports = Game;
