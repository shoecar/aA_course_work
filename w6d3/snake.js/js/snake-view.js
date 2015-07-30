!function () {
  if (typeof Game === "undefined") {
    window.Game = {};
  }

  var View = Game.View = function ($el, gridSize) {
    this.$el = $el;
    this.board = new Game.Board(gridSize);
    this.gridSize = gridSize;
    this.render();
  }

  View.prototype.move = function () {
  };

  View.prototype.render = function () {
    for (var i = 0; i < this.gridSize; i++) {
      var row = $('<div>');
      for (var j = 0; j < this.gridSize; j++) {
        var cell = $('<pre>').text(this.board.grid[i][j]);
        row.append(cell);
      }
      this.$el.append(row);
    }
  };
}();
