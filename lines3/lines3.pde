int NUMROW = 7;
int NUMCOL = 7;
float lineHeight = 35;
float lineWidth = 4;
int time = 0;
float rate = PI/(200.0);
float rate2 = PI/(50.0);

void setup(){
  pushMatrix();
  size(600,600);
  noStroke();
  fill(110);
  rect(0,0,599,599);
  colorMode(HSB, 360, 100, 100, 100);
  fill(255);
}

void drawLine(int row, int col, float time){
  pushMatrix();
  float cellX = 150+(300/(NUMROW-1))*row;
  float cellY = 150+(300/(NUMCOL-1))*col;
  float dist = (sqrt(pow(row - 0.5*(NUMROW-1), 2.0) + pow(col - 0.5*(NUMCOL-1), 2.0)))/(sqrt(2));
  int factor = 1;
  if(dist > 0.1 && dist <= 1.1){
    factor = 2;
  }else if(dist > 1.1 && dist <= 2.1){
    factor = 3;
  }else if(dist > 2.1){
    factor = 6;
  }
  fill(205, 6*factor+50, 100 - 6*factor);
  float angle = factor*rate*time - (factor*rate/rate2)*sin(rate2*time);
  translate(cellX, cellY);
  rotate(angle);
  translate(-0.5*lineWidth, -0.5*lineHeight);
  rect(0,0,lineWidth,lineHeight);
  popMatrix();
  if(row==0 && col==0){
    //ellipse(centerX, centerY, 10,10);
    //print("dist2cent: "+dist2cent+"\n");
  }
}

void draw(){
 fill(225, 50, 20);
 if(time < 300 && (time/100)%2 == 0){
   rect(0,0,600,600);
   fill(205, 60, 100);
   pushMatrix();
   if(time/200 >= 1){
     translate(300,300);
     rotate(PI/2.0*(time/200));
     translate(-300,-300);
   }
   for(int row = 0; row < NUMROW; row++){
     for(int col = 0; col < NUMCOL; col++){
         drawLine(row, col, time);
     }
   }
   popMatrix();
   saveFrame("./tmp/line3v1-0_####.png");
 }else if(time < 400 && (time/100)%2 == 1){
   rect(0,0,600,600);
   fill(205, 60, 100);
   pushMatrix();
   if(time/200 >= 1){
     translate(300,300);
     rotate(PI/2.0*(time/200));
     translate(-300,-300);
   }
   float angle = rate*(time-100*((time/100)%2)) - (rate/rate2)*sin(rate2*(time-100*((time/100)%2)));
   translate(300,300);
   rotate(-angle);
   translate(-300, -300);
   for(int row = 0; row < NUMROW; row++){
     for(int col = 0; col < NUMCOL; col++){
         drawLine(row, col, time);
     }
   }
   popMatrix();
   saveFrame("./tmp/line3v1-0_####.png");
 }else{
   noLoop();
 }
 time+=1;
}