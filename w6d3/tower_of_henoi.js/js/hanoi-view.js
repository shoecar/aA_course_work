!function () {
  if(typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, view) {
    this.game = game;
    this.view = view;
    this.click = -1;
    this.setUpTowers();
    this.setUpEvents();
    this.render();
  };

  View.prototype.setUpTowers = function () {
    for (var i = 0; i < 3; i++) {
      // var $disk = $("<div>").addClass("column").data("number", i)
      this.view.append("<div class='column'><div class='drop'></div></div>");
      this.view.children().eq(i).data("number", i);
    }
  };

  View.prototype.render = function () {
    var towers = this.game.towers;
    $('.disk').remove();
    for (var i = 0; i < towers.length; i++) {
      for (var j = towers[i].length - 1; j >= 0; j--) {
        // var $disk = $("<div>").addClass(disk).addClass("s" + )
        var disk = $("<div class='disk s" + (towers[i][j]) + "'></div>");
        this.view.children().eq(i).children().eq(0).append(disk);
      };
    }
  };

  View.prototype.setUpEvents = function () {
    var that = this
    this.view.children().on("click", this.clickTower.bind(this));
  };

  View.prototype.clickTower = function (event) {
    var number = $(event.currentTarget).data("number");
    if (this.click < 0) { //if there wasn't a click before
      if (this.game.towers[number].length > 0) {
        this.click = number;
        $('.column').eq(number).addClass('selected')
      } else {
        alert("Can't move from empty tower!");
      }
    } else {
      if (this.game.move(this.click, number) ) {
        if (this.game.isWon()) {
          $('h1').text('YOU WON!');
          $('.column').off("click");
        }
      }
      $('.column').eq(this.click).removeClass('selected');
      this.click = -1;
      this.render();
    }
  };
}();
