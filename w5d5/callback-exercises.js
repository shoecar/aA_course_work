function Clock () {
}

Clock.TICK = 1000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log(this.hours + ":" + this.minutes + ":" + this.seconds);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  var currentTime = new Date();
  this.seconds = currentTime.getSeconds();
  this.minutes = currentTime.getMinutes();
  this.hours = currentTime.getHours();
  this.printTime();
  var tickFunction = this._tick.bind(this);
  setInterval(tickFunction, Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.seconds += Clock.TICK / 1000;
  if (this.seconds > 59) {
    this.seconds -= 60;
    this.minutes++;
  }
  if (this.minutes > 59) {
    this.minutes -= 60;
    this.hours++;
  }
  if (this.hours > 23) {
    this.hours = 0;
  }
  this.printTime();
};

var clock = new Clock();
clock.run();

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function (num) {
      num = parseInt(num, 10);
      console.log(sum += num);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
}

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });
