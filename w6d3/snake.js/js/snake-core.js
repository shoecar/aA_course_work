(function () {
  if (typeof Game === "undefined") {
    window.Game = {};
  }

  var Coord = {};

  Coord.plus = function (coord, dir) {
    return [coord[0] + dir[0], coord[1] + dir[1]];
  };

  Coord.equals = function (coord1, coord2) {
    return (coord1[0] === coord2[0] && coord1[1] === coord2[1]);
  };
  //
  // isOpposite

  var Snake = Game.Snake = function (gridSize) {
    this.dir = "N";
    this.segments = [[Math.floor(gridSize/2), Math.floor(gridSize/2)]];
  };

  Snake.DIRS = {
    N: [-1, 0],
    S: [ 1, 0],
    E: [ 0,-1],
    W: [ 0, 1]
  };

  Snake.prototype.move = function () {
    this.segments.unshift( Coord.plus(this.segments[0], Snake.DIRS[this.dir]));
    this.segments.pop();
  };

  Snake.prototype.turn = function (dir) {
    this.dir = dir;
  };

  var Board = Game.Board = function (gridSize) {
    this.snake = new Snake(gridSize);
    this.grid = [];
    this.populateGrid(gridSize);
    this.placeSnake();
  }

  Board.prototype.populateGrid = function (gridSize) {
    for (var i = 0; i < gridSize; i++) {
      this.grid.push(new Array(gridSize));
      for (var j = 0; j < gridSize; j++) {
        this.grid[i][j] = ".";
      }
    }
  }

  Board.prototype.placeSnake = function () {
    var that = this;
    this.snake.segments.forEach(function (segment) {
      that.grid[segment[0]][segment[1]] = "S";
    });
  }


})();
