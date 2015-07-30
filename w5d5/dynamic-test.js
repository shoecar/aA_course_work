function Board() {
    this.grid = [
      ["x", "o", "x"],
      ["o", "x", "o"],
      ["o", "o", "x"]
    ]
}

Board.prototype.isWon = function (symbol) {
  // Dynamic programming solution utilizing matrix.
  // Matrix one height and two width larger than tic tac toe board.
  var dynamicMatrix = [];
  for (var i = 0; i < this.grid.length + 1; i++) {
    dynamicMatrix.push(new Array(this.grid[0].length + 2));
  }

  // Populate empty matrix.
  for (var i = 0; i < dynamicMatrix.length; i++) {
    for (var j = 0; j < dynamicMatrix[0].length; j++) {
      dynamicMatrix[i][j] = [0, 0, 0, 0] // [left, left diag, top, right diag]
    }
  }

  // Each square in the dynamicMatrix records how many of its own pieces
  // exist in each of the four directions: left, leftdiag, up, rightdiag.
  for (var i = 1; i < this.grid.length + 1; i++) {
    for (var j = 1; j < this.grid[0].length + 1; j++) {
      var current = dynamicMatrix[i][j];
      var space = this.grid[i - 1][j - 1]
      if(space === symbol) {
        current[0] += (1 + dynamicMatrix[i    ][j - 1][0]);
        current[1] += (1 + dynamicMatrix[i - 1][j - 1][1]);
        current[2] += (1 + dynamicMatrix[i - 1][j    ][2]);
        current[3] += (1 + dynamicMatrix[i - 1][j + 1][3]);

        // If it's found a 3, there are three pieces in a row.
        if(current.indexOf(3) > -1) {
          console.log(current)
          return true };
      }
    }
  }
  return false;
}

b = new Board();
console.log(b.isWon("x"))
