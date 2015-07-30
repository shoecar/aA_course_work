var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function HanoiGame(stacks) {
  this.stacks = stacks;
  this.disks = stacks[0].length;
}

HanoiGame.prototype.isWon = function () {
  if (stacks[1].length === this.disks || stacks[2].length === this.disks) {
    return true;
  } else {
    return false;
  }
}

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  var startDisk = this.stacks[startIdx][stacks[startIdx].length - 1];
  var endDisk = this.stacks[endIdx][stacks[endIdx].length - 1];
  if (startDisk !== undefined &&
       (endDisk === undefined || endDisk > startDisk)) {
    return true;
  } else {
    return false;
  }
}

HanoiGame.prototype.move = function (startIdx, endIdx) {
  if (this.isValidMove(startIdx, endIdx)) {
    this.stacks[endIdx].push(this.stacks[startIdx].pop());
    return true;
  } else {
    console.log("Invalid move")
    return false;
  }
}

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
}

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  var startIdx, endIdx;

  reader.question("Give stack to move from: ", function (ans) {
    startIdx = ans;
    reader.question("Give stack to move to: ", function (ans) {
      endIdx = ans;
      callback(startIdx, endIdx);
    });
  });
}

HanoiGame.prototype.run = function (completionCallback) {
  var boundIsWon = this.isWon.bind(this);
  var boundRun = this.run.bind(this);
  var boundMove = this.move.bind(this);
  this.promptMove(function (startIdx, endIdx) {
    boundMove(startIdx, endIdx);
    if (boundIsWon()) {
      completionCallback();
    } else {
      boundRun(completionCallback);
    }
  });
}

var stacks = [
  [3, 2, 1],
  [],
  []
];

game = new HanoiGame(stacks);
game.run(function () {
  console.log("You won the game, yay!");
  reader.close();
});
