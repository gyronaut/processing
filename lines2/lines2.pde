int NUMROW = 10;
int NUMCOL = 10;
float lineHeight = 33;
float lineWidth = 4;
int time = 0;
float rate = PI/(250.0);

void setup(){
  pushMatrix();
  size(600,600);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  drawBG();
  drawBG();
  drawBG();
  drawBG();
}

void drawLine(int row, int col, int layer, float time){
  pushMatrix();
  float cellX = 52+66*(layer)+(297/(NUMROW-1))*row;
  float cellY = 52+66*(layer)+(297/(NUMCOL-1))*col;
  if(layer!=0){
    //cellX-=0.5;
  }
  translate(cellX+1.5, cellY);
  rotate(rate*float(5-layer)*time);
  translate(-0.5*lineWidth, -0.5*lineHeight);
  fill(300,25*layer,100);
  rect(0,0,lineWidth,lineHeight);
  popMatrix();
  if(row==0 && col==0){
    //ellipse(centerX, centerY, 10,10);
    //print("dist2cent: "+dist2cent+"\n");
  }
}

void drawBG(){
  pushMatrix();
  rotate(PI/4.0);
  color c1 = color(250, 35, 30);
  color c2 = color(250, 5, 60);
  for(int i = 0; i<600*sqrt(2); i++){
    float iter = map(i, 0, 600*sqrt(2), 0, 1);
    color c = lerpColor(c1, c2, iter);
    fill(c);
    rect(i, -0.5*600*sqrt(2), 1, 600*sqrt(2));
  }
  popMatrix();
}


void draw(){
 if(time < 25){
   drawBG();
   for(int layer = 0; layer < 4; layer++){
     for(int row = 0; row < NUMROW; row++){
       for(int col = 0; col < NUMCOL; col++){
           drawLine(row, col, layer, 0);
       }
     }
   }
   saveFrame("./tmp/line2v1-1_####.png");
 }
 if(time >=25 && time <= 275){
   //fill(250,20,50);
   //rect(0,0,600,600);
   drawBG();
   for(int layer = 0; layer < 4; layer++){
     for(int row = 0; row < NUMROW; row++){
       for(int col = 0; col < NUMCOL; col++){
           drawLine(row, col, layer, time-25);
       }
     }
   }
   saveFrame("./tmp/line2v1-1_####.png");
 }else if(time > 275){
   noLoop();
 }
 time+=1;
}