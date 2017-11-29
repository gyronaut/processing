var NUMROW = 7;
var NUMCOL = 7;
var lineHeight = 24;
var lineWidth = 3;
var time = 0;
var rate = 3.14159/(200.0);
var rate2 = 3.14159/(50.0);
var isLoop = false;
var cnv;

function setup(){
  //createCanvas(100,100);
  //fill(255);
  //rect(50,50,50,50);
  //var div = createDiv("");
  //div.style('cursor','pointer');
  var cnv = createCanvas(400,400);
  cnv.mouseClicked(line3Loop);
  cnv.style('cursor', 'pointer');
  push();
  noStroke();
  fill(110);
  rect(0,0,600,600);
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(60);
  fill(255);
  noLoop();
}

function line3Loop(){
    if(isLoop){
        noLoop();
        isLoop = false;
    }else{
        loop();
        isLoop = true;
    }
}

function drawLine(row, col, time){
  push();
  var cellX = 100+(200/(NUMROW-1))*row;
  var cellY = 100+(200/(NUMCOL-1))*col;
  var dist = (sqrt(pow(row - 0.5*(NUMROW-1), 2.0) + pow(col - 0.5*(NUMCOL-1), 2.0)))/(sqrt(2));
  var factor = 1;
  if(dist > 0.1 && dist <= 1.1){
    factor = 2;
  }else if(dist > 1.1 && dist <= 2.1){
    factor = 3;
  }else if(dist > 2.1){
    factor = 6;
  }
  fill(205, 6*factor+50, 100 - 6*factor);
  var angle = factor*rate*time - (factor*rate/rate2)*sin(rate2*time);
  translate(cellX, cellY);
  rotate(angle);
  translate(-0.5*lineWidth, -0.5*lineHeight);
  rect(0,0,lineWidth,lineHeight);
  pop();
  if(row==0 && col==0){
    //ellipse(centerX, centerY, 10,10);
    //prvar("dist2cent: "+dist2cent+"\n");
  }
}

function draw(){
 fill(225, 50, 20);
 if(floor(time/100)%2 == 0){
   rect(0,0,600,600);
   fill(205, 60, 100);
   push();
   if(time/200 >= 1){
     translate(200,200);
     rotate(3.14159/2.0*floor(time/200));
     translate(-200,-200);
   }
   for(var row = 0; row < NUMROW; row++){
     for(var col = 0; col < NUMCOL; col++){
         drawLine(row, col, time);
     }
   }
   pop();
   //saveFrame("./tmp/line3v1-0_####.png");
 }else if(floor(time/100)%2 == 1){
   rect(0,0,600,600);
   fill(205, 60, 100);
   push();
   if(time/200 >= 1){
     translate(200,200);
     rotate(3.14159/2.0*floor(time/200));
     translate(-200,-200);
   }
   var angle = rate*(time-100*(floor(time/100)%2)) - (rate/rate2)*sin(rate2*(time-100*(floor(time/100)%2)));
   translate(200,200);
   rotate(-angle);
   translate(-200, -200);
   for(var row = 0; row < NUMROW; row++){
     for(var col = 0; col < NUMCOL; col++){
         drawLine(row, col, time);
     }
   }
   pop();
   //saveFrame("./tmp/line3v1-0_####.png");
 }
 time+=1;
}
