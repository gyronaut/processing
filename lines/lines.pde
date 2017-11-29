int NUMROW = 30;
int NUMCOL = 30;
float lineHeight = 10;
int time = 0;
float rate = PI/(50.0);
float centerRate = PI/(100.0);
float angles[][] = new float[30][30];

void setup(){
  pushMatrix();
  size(600,600);
  noStroke();
  fill(170);
  rect(0,0,600,600);
  colorMode(HSB, 360, 100, 100, 100);
  fill(255);
  for(int row = 0; row < NUMROW; row++){
   for(int col = 0; col < NUMCOL; col++){
     rect(50+(500/(NUMROW-1))*(row),50+(500/(NUMCOL-1))*(col),2,lineHeight);
   }
  }
}

float drawLine(int row, int col, float prevAngle, float time){
  pushMatrix();
  float centerX = 0.0; 
  float centerY = 0.0;
  if(time < 500){
    centerX = 600*(0.5+0.3*cos(centerRate*time));
    centerY = 600*(0.5+0.3*sin(centerRate*time));
  }else{
    centerX = 600*(0.5+0.3*cos(-1.0*centerRate*time));
    centerY = 600*(0.5+0.3*sin(-1.0*centerRate*time));
  }
  float cellX = 50+(500/(NUMROW-1))*row;
  float cellY = 50+(500/(NUMCOL-1))*col;
  float dist2cent = (pow(abs(pow(cellX-centerX, 4.0)) + abs(pow(cellY-centerY, 4.0)), 1.0/4.0)/pow((pow(0.5*500, 4.0) + pow(0.5*500, 4.0)), 1.0/4.0));
  float angle = prevAngle;
  if(time < 500){
    angle+= rate*dist2cent;
  }else{
    angle-= rate*dist2cent;
  }
  float h = 1+lineHeight*dist2cent;
  translate(cellX, cellY);
  rotate(angle);
  translate(0, -0.5*h);
  rect(0,0,2,h);
  popMatrix();
  if(row==0 && col==0){
    //ellipse(centerX, centerY, 10,10);
    //print("dist2cent: "+dist2cent+"\n");
  }
  return angle;
}

void draw(){
 fill(170);
 if(time < 1000){
   rect(0,0,600,600);
   fill(255);
   for(int row = 0; row < NUMROW; row++){
     for(int col = 0; col < NUMCOL; col++){
       if(time==0){
         angles[row][col] = 0.0;
       }
         angles[row][col] = drawLine(row, col, angles[row][col], time);
     }
   }
   saveFrame("./tmp/linev1-0_####.png");
 }else{
   noLoop();
 }
 time+=1;
}