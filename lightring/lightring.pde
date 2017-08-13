color[][] configurations = new color[3][30];
int index = 0;
int w = 35;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  
  //config 1
  configurations[0][0] = color(316,13,90);
  configurations[0][1] = color(34,60,95);
  configurations[0][2] = color(51,63,95);
  configurations[0][3] = color(10,44,99);
  configurations[0][4] = color(2,30,99);
  configurations[0][5] = color(19,90,98);
  configurations[0][6] = color(344,67,95);
  configurations[0][7] = color(321,40,99);
  configurations[0][8] = color(0,0,0);
  configurations[0][9] = color(0,0,0);
  configurations[0][10] = color(0,0,0);
  configurations[0][11] = color(0,0,0);
  configurations[0][12] = color(0,0,0);
  configurations[0][13] = color(0,0,0);
  configurations[0][14] = color(0,0,0);
  configurations[0][15] = color(0,0,0);
  configurations[0][16] = color(0,0,0);
  configurations[0][17] = color(0,0,0);
  configurations[0][18] = color(0,0,0);
  configurations[0][19] = color(0,0,0);
  configurations[0][20] = color(0,0,0);
  configurations[0][21] = color(0,0,0);
  configurations[0][22] = color(0,0,0);
  configurations[0][23] = color(0,0,0);
  configurations[0][24] = color(0,0,0);
  configurations[0][25] = color(0,0,0);
  configurations[0][26] = color(0,0,0);
  configurations[0][27] = color(0,0,0);
  configurations[0][28] = color(40,33,80);
  configurations[0][29] = color(303,97,99);
  
  //config 2
  configurations[1][0] = color(0,0,0);
  configurations[1][1] = color(0,0,0);
  configurations[1][2] = color(0,0,0);
  configurations[1][3] = color(0,0,0);
  configurations[1][4] = color(0,0,0);
  configurations[1][5] = color(0,0,0);
  configurations[1][6] = color(0,0,0);
  configurations[1][7] = color(0,0,0);
  configurations[1][8] = color(0,0,0);
  configurations[1][9] = color(0,0,0);
  configurations[1][10] = color(0,0,0);
  configurations[1][11] = color(0,0,0);
  configurations[1][12] = color(0,0,0);
  configurations[1][13] = color(0,0,0);
  configurations[1][14] = color(186,51,70);
  configurations[1][15] = color(203,97,99);
  configurations[1][16] = color(261,70,95);
  configurations[1][17] = color(171,62,99);
  configurations[1][18] = color(230,60,90);
  configurations[1][19] = color(125,90,90);
  configurations[1][20] = color(212,75,75);
  configurations[1][21] = color(261,92,80);
  configurations[1][22] = color(233,90,99);
  configurations[1][23] = color(0,0,0);
  configurations[1][24] = color(0,0,0);
  configurations[1][25] = color(0,0,0);
  configurations[1][26] = color(0,0,0);
  configurations[1][27] = color(0,0,0);
  configurations[1][28] = color(0,0,0);
  configurations[1][29] = color(0,0,0);
  
  //config 3
  configurations[2][0] = color(316,13,90);
  configurations[2][1] = color(34,60,95);
  configurations[2][2] = color(51,63,95);
  configurations[2][3] = color(10,44,99);
  configurations[2][4] = color(2,30,99);
  configurations[2][5] = color(19,90,98);
  configurations[2][6] = color(344,67,95);
  configurations[2][7] = color(321,40,99);
  configurations[2][8] = color(0,0,0);
  configurations[2][9] = color(0,0,0);
  configurations[2][10] = color(0,0,0);
  configurations[2][11] = color(0,0,0);
  configurations[2][12] = color(0,0,0);
  configurations[2][13] = color(0,0,0);
  configurations[2][14] = color(186,51,70);
  configurations[2][15] = color(203,97,99);
  configurations[2][16] = color(261,70,95);
  configurations[2][17] = color(171,62,99);
  configurations[2][18] = color(230,60,90);
  configurations[2][19] = color(125,90,90);
  configurations[2][20] = color(212,75,75);
  configurations[2][21] = color(261,92,80);
  configurations[2][22] = color(233,90,99);
  configurations[2][23] = color(0,0,0);
  configurations[2][24] = color(0,0,0);
  configurations[2][25] = color(0,0,0);
  configurations[2][26] = color(0,0,0);
  configurations[2][27] = color(0,0,0);
  configurations[2][28] = color(40,33,80);
  configurations[2][29] = color(303,97,99);
}

void draw(){
  for(int i = 0; i< 30; i++){
      fill(configurations[index][i]);
      ellipse(300+250*sin(i*12.0*(PI)/(180.0)), 300-250*cos(i*12.0*(PI)/(180.0)), w, w);
      fill(0);
      text(""+i, 295+215*sin(i*12.0*(PI)/(180.0)), 305-215*cos(i*12.0*(PI)/(180.0)));
  }
}

void keyPressed(){
  if(key == ENTER){
    index = (index+1)%3;
    draw();
  }
}
