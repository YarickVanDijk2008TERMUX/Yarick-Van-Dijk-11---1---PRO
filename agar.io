function Blob(x, y, r) {
  this.pos = createVector(x, y); // create 'x' and 'y'
  this.score = createVector(width / 1, height / 1);
  this.r = r; // create 'r'
  this.vel = createVector(0, 0); // create 'velocity'

  this.name = function () {}

  this.update = function () {
    var newvel = createVector(mouseX - width / 2, mouseY - height / 2); // if you pressed the screen you go into the pressed place
    newvel.div(50);
    // newvel.setMag(3);
    newvel.limit(3);
    this.vel.lerp(newvel, 0.5); // How fast turning to the other side
    this.pos.add(this.vel); // CREATING...
  }

  this.eats = function (other) {
    var d = p5.Vector.dist(this.pos, other.pos); // ad the function of 'dist'
    if (d < this.r + other.r) {
      var sum = PI * this.r * this.r + PI * other.r * other.r;
      this.r = sqrt(sum / PI);
      //this.r += other.r*0.17;
      return true; // bigger
    } else {
      return false; // smaller
    }
  }

  this.showredmass = function () {
    fill(255, 46, 84); // color
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle
  }

  this.showbluemass = function () {
    fill(46, 86, 255); // color
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle
  }

  this.showyellowmass = function () {
    fill(235, 195, 52); // color
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle
  }

  this.showgreenmass = function () {
    fill(104, 235, 52); // color
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle
  }

  this.showpinkmass = function () {
    fill(217, 41, 123); // color
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle
  }

<!-- =============================================================================================================================== -->
<!-- new file ====================================================================================================================== -->
<!-- =============================================================================================================================== -->

  this.showjackpot = function () {
    fill(0, 57, 255); // color
    stroke(0); // stroke color
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle

    push();
    translate(this.pos.x, this.pos.y);
    beginShape();
    for (var c = 0; c < TWO_PI; c += 0.1) {
      var offset = map(sin(c * frameCount - 0.1 * 2 - 3 * 7.8 - 17 * 7), 1, -1, 5, -5);
      var r = this.r + offset;
      var x = r * cos(c);
      var y = r * sin(c);
      vertex(x, y);
    }
    endShape();
    pop();
  }

  this.showblobs = function () {
    fill(35, 74, 46);
    ellipse(random(width), random(height), 32, 32);
  }

  this.showvirusses = function () {
    fill(139, 239, 116); // color
    push(); // begin for: text, animations..
    translate(this.pos.x, this.pos.y);
    beginShape(); // begin animation
    for (var a = 0; a < TWO_PI; a += 0.1) {
      var offset = map(sin(a + frameCount * 0.1), -1, 2, -10, 10); // create variable
      var r = this.r + offset; // create variable
      var x = r * cos(a); // create variable
      var y = r * sin(a); // create variable
      vertex(x, y); // add 'x', 'y'
      ellipse(x, y, 15, 10); // circle
    }
    endShape(); // end animation
    pop(); // end for: text, animations..
  }

  this.show = function () {
    fill(255, 70, 10);
    stroke(0, 255, 0);
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2); // circle

    push(); // begin for: text, animations..
    fill(0);
    stroke(0);
    text("PLAYER: ", this.pos.x - 300, this.pos.y - 400);

    fill(100, 200, 50); // color
    stroke(0);
    rectMode(CENTER); // rectangle to the middle of the screen
    rect(this.pos.x, this.pos.y - 410, 160, 50); // rectangle

    fill(0); // color
    stroke(0);
    textSize(35); // size of text
    textAlign(CENTER); // set text to the middle of the screen
    text(name, this.pos.x, this.pos.y - 400); // text
    pop(); // end for: text, animations..

    push(); // begin for: text, animations..

    var five = 5;

    fill(136);
    stroke(0);
    rect(10, 0, 300, 75);

    fill(0); // color
    stroke(0);
    textSize(35); // size of text
    text("By 'Yarick Van Dijk'", 15, 38); // text
    pop(); // end for: text, animations..

    // create button...

    button1 = createButton;

    // make sprite effects

    this.throwmass = function () {
      fill(0);
      ellipse(mouseX, mouseY, playerSize, playerSize);
    }

    // score...

    fill(46, 8, 255);
    stroke(0);
    textSize(20);
    text(score, this.pos.x - 15, this.pos.y);
  }
}

<!-- =============================================================================================================================== -->
<!-- new file ====================================================================================================================== -->
<!-- =============================================================================================================================== -->

/*
-----------------------------------------
By: [

' Yarick Van Dijk '

]
-----------------------------------------
*/
var wkey = false;


var blob; // To create your sprite
var button; // To create buttons

var redblobs = []; // To create the pellets
var blueblobs = [];
var yellowblobs = [];
var greenblobs = [];
var pinkblobs = [];
var addBlobs = [];
var virusses = []; // To create virusses
var zoom = 0.1; // If you eat you zoom out
var jackpot = []; // To create random cells

var colors = [
  ["#c98d0a", "#2d63cf"],
  ["#cc3d90", "#4b8f24"],
  ["#5fbacf", "#a34f0a"]
];

var score = 12;
var newpelet = 0;

let playerSize = 20;

function setup() {
  createCanvas(windowWidth - 10, windowHeight - 20); // Create your canvas size 'width', 'height'
  blob = new Blob(0, 0, playerSize); // Big from your sprite

  background(255);

  socket = io.connect('http://127.0.0.1:5500/Visual%20Studio%20Code/agario/PAGE.html');


  socket.on('mouse',
    function (data) {
      console.log("Got: " + data.x + " " + data.y);
      fill(0, 0, 255);
      noStroke();
      ellipes(data.x, data.y, playerSize, playerSize);
    }
  );

  // Question what is your name

  name = prompt("What is your name?\nIt can have 6 characters");

  if (name.length > 6) {
    name = name.slice(0, 6) + "_"; // It can have 6 characters
  }

  for (var i = 0; i < 59; i++) {
    var x = random(-width, width); // Randomizing...
    var y = random(-height, height); // Randomizing...
    redblobs[i] = new Blob(x, y, random(5.9, 9)); // Creating small to big pellets
  }

  for (var i = 0; i < 52; i++) {
    var x = random(-width, width);
    var y = random(-height, height);
    blueblobs[i] = new Blob(x, y, random(5.9, 9));
  }

  for (var i = 0; i < 52; i++) {
    var x = random(-width, width);
    var y = random(-height, height);
    yellowblobs[i] = new Blob(x, y, random(5.9, 9));
  }

  for (var i = 0; i < 52; i++) {
    var x = random(-width, width);
    var y = random(-height, height);
    greenblobs[i] = new Blob(x, y, random(5.9, 9));
  }

  for (var i = 0; i < 52; i++) {
    var x = random(-width, width);
    var y = random(-height, height);
    pinkblobs[i] = new Blob(x, y, random(5.9, 9));
  }

  for (var i = 0; i < 9; i++) {
    var x = random(-width, width); // Randomizing...
    var y = random(-height, height); // Randomizing...
    virusses[i] = new Blob(x, y, 50); // Creating virusses...
  }

  for (var i = 0; i < 4; i++) {
    var x = random(-width, width); // Randomizing...
    var y = random(-height, height); // Randomizing...
    jackpot[i] = new Blob(x, y, 40); // Creating cells...
  }
  // Colors...

  var colors = [
    ["#c98d0a", "#2d63cf"],
    ["#cc3d90", "#4b8f24"],
    ["#5fbacf", "#a34f0a"]
  ];
}

function draw() {
  background(255); // The background

  // zoom if you eat something...

  translate(width / 2, height / 2);
  var newzoom = 64 / blob.r;
  zoom = lerp(zoom, newzoom, 0.06);
  scale(zoom);
  translate(-blob.pos.x, -blob.pos.y);

  //
  //
  //

  // What is happening with another things...

  for (var i = redblobs.length - 1; i >= 0; i--) {
    redblobs[i].showredmass(1); // in the blob function
    if (blob.eats(redblobs[i])) {
      redblobs.splice(i, 1); // All Blobs are dead
      score += 1;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width); // Randomizing...
        var y = random(-height, height); // Randomizing...
        redblobs[m] = new Blob(x, y, random(5.9, 9)); // Creating small to big pellets
      }
    }
  }

  for (var i = blueblobs.length - 1; i >= 0; i--) {
    blueblobs[i].showbluemass(1);
    if (blob.eats(blueblobs[i])) {
      blueblobs.splice(i, 1);
      score += 1;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width);
        var y = random(-height, height);
        blueblobs[m] = new Blob(x, y, random(5.9, 9));
      }
    }
  }

  for (var i = yellowblobs.length - 1; i >= 0; i--) {
    yellowblobs[i].showyellowmass(1);
    if (blob.eats(yellowblobs[i])) {
      yellowblobs.splice(i, 1);
      score += 1;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width);
        var y = random(-height, height);
        yellowblobs[m] = new Blob(x, y, random(5.9, 9));
      }
    }
  }

  for (var i = greenblobs.length - 1; i >= 0; i--) {
    greenblobs[i].showgreenmass(1);
    if (blob.eats(greenblobs[i])) {
      greenblobs.splice(i, 1);
      score += 1;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width);
        var y = random(-height, height);
        greenblobs[m] = new Blob(x, y, random(5.9, 9));
      }
    }
  }

  for (var i = pinkblobs.length - 1; i >= 0; i--) {
    pinkblobs[i].showpinkmass(1);
    if (blob.eats(pinkblobs[i])) {
      pinkblobs.splice(i, 1);
      score += 1;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width);
        var y = random(-height, height);
        pinkblobs[m] = new Blob(x, y, random(5.9, 9));
      }
    }
  }

  for (var i = virusses.length - 1; i >= 1; i--) {
    virusses[i].showvirusses(60); // in the blob function
    if (blob.eats(virusses[i])) {
      virusses.splice(i, 1); // Virusses or Blob are dead
      score += 60;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width); // Randomizing...
        var y = random(-height, height); // Randomizing...
        virusses[m] = new Blob(x, y, 50); // Creating virusses...
      }
    }
  }

  for (var i = jackpot.length - 1; i >= 0; i--) {
    jackpot[i].showjackpot(40); // in the blob function
    if (blob.eats(jackpot[i])) {
      jackpot.splice(i, 1); // The jackpot are dead
      score += 70;
      for (var m = 0; m < 1; m++) {
        var x = random(-width, width); // Randomizing...
        var y = random(-height, height); // Randomizing...
        jackpot[m] = new Blob(x, y, 40); // Creating cells...
      }
    }
  }

  // What is happenning with the sprite

  blob.show();
  blob.update();

  // If you pressed something...

  function keyPressed() {
    if (key == "w") {
      console.log("W");
    }
    if (key == " ") {
      console.log("SPACE");
    }
  }
}

function keyPressed() {
  if (key == 'w') {
    wkey = true;
    fill(0);
    ellipse(mouseX, mouseY, playerSize, playerSize);
  }
}

function keyReleased() {
  if (key == 'w') {
    wkey = false;
  }
}

<!-- =============================================================================================================================== -->
<!-- new file ====================================================================================================================== -->
<!-- =============================================================================================================================== -->

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/p5.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/addons/p5.sound.min.js"></script>

  <script src="https://cdn.socket.io/socket.io-1.4.5.js" <script
    src="https://cdnjs.cloudflare.com/ajax/libs/processing.js/1.6.6/processing.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/processing.js/1.6.6/processing.min.js"></script>

  <title>AGARIO</title>
</head>

<body>
  <script src="agario-setup.js"></script>
  <script src="blob.js"></script>
</body>

</html>
