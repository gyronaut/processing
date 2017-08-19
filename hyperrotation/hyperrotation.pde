float hyper[][] = new float[36][4];
float rotation[][] = new float[4][4];
float projection[][] = new float[36][2];
float rotationX[][] = new float[4][4];
float rotationY[][] = new float[4][4];
float rotationZ[][] = new float [4][4];
float rotationW[][] = new float [4][4];
color vtxColors[] = new color[36];

float theta1 = 0.01;
float theta2 = 0.01;
float w = 600;
float alpha = PI/7.0;
float beta = PI/5.0;
float gamma = PI/3.0;
float delta = PI/11.0;

float RANDMAX = 0.1;
boolean isCube = true;
float fade = 0.0;

void setup(){
    //background(0.0);
    size(600, 600, P3D);
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
    //noLoop();
    translate(0,0,0);
    pushMatrix();
    translate(0,0,300);
    fill(0.0, 0.0, 0.0, 100);
    rect(0,0,600,600);
    popMatrix();

    //setup Colors
    for(int i = 0; i< 16; i++){
        //vtxColors[i] = color(170 + 5*i, 100 - (3.75*i), 99);
    }

    //set-up rotation matrices:
    for(int i = 0; i<4; i++){
        rotationX[0][i] = 0.0;
        rotationX[3][i] = 0.0;
        rotationX[i][0] = 0.0;
        rotationX[i][3] = 0.0;
        rotationY[i][1] = 0.0;
        rotationY[i][3] = 0.0;
        rotationY[1][i] = 0.0;
        rotationY[3][i] = 0.0;
        rotationZ[2][i] = 0.0;
        rotationZ[3][i] = 0.0;
        rotationZ[i][2] = 0.0;
        rotationZ[i][3] = 0.0;
        rotationW[i][1] = 0.0;
        rotationW[1][i] = 0.0;
        rotationW[i][2] = 0.0;
        rotationW[2][i] = 0.0;
    }
    rotationX[0][0] = 1.0;
    rotationX[3][3] = 1.0;
    rotationY[1][1] = 1.0;
    rotationY[3][3] = 1.0;
    rotationZ[2][2] = 1.0;
    rotationZ[3][3] = 1.0;
    rotationW[1][1] = 1.0;
    rotationW[2][2] = 1.0;

    rotationX[1][1] = cos(alpha);
    rotationX[1][2] = sin(alpha);
    rotationX[2][1] = -sin(alpha);
    rotationX[2][2] = cos(alpha);

    rotationY[0][0] = cos(beta);
    rotationY[0][2] = -sin(beta);
    rotationY[2][0] = sin(beta);
    rotationY[2][2] = cos(beta);

    rotationZ[0][0] = cos(gamma);
    rotationZ[0][1] = sin(gamma);
    rotationZ[1][0] = -sin(gamma);
    rotationZ[1][1] = cos(gamma);

    rotationW[0][0] = cos(delta);
    rotationW[0][3] = -sin(delta);
    rotationW[3][0] = sin(delta);
    rotationW[3][3] = cos(delta);

    //set-up 4D vertices for eye
    hyper[0][0] = -6*(0.06)*w + 0.5*w;
    hyper[0][1] = 0*(0.06)*w + 0.5*w;
    hyper[0][2] = 0.5*w;
    hyper[0][3] = 0.5*w;
    
    hyper[1][0] = -2*(0.06)*w + 0.5*w;
    hyper[1][1] = -3*(0.06)*w + 0.5*w;
    hyper[1][2] = 2*(0.06)*w + 0.5*w;
    hyper[1][3] = 2*(0.06)*w + 0.5*w;

    hyper[2][0] = 2*(0.06)*w + 0.5*w;
    hyper[2][1] = -3*(0.06)*w + 0.5*w;
    hyper[2][2] = 2*(0.06)*w + 0.5*w;
    hyper[2][3] = 2*(0.06)*w + 0.5*w;

    hyper[3][0] = 6*(0.06)*w + 0.5*w;
    hyper[3][1] = 0*(0.06)*w + 0.5*w;
    hyper[3][2] = 0.5*w;
    hyper[3][3] = 0.5*w;

    hyper[4][0] = 0*(0.06)*w + 0.5*w;
    hyper[4][1] = 3*(0.06)*w + 0.5*w;
    hyper[4][2] = 2*(0.06)*w + 0.5*w;
    hyper[4][3] = 2*(0.06)*w + 0.5*w;
    
    hyper[5][0] = -3*(0.06)*w + 0.5*w;
    hyper[5][1] = 0*(0.06)*w + 0.5*w;
    hyper[5][2] = 2*(0.06)*w + 0.5*w;
    hyper[5][3] = 2*(0.06)*w + 0.5*w;
    
    hyper[6][0] = -2*(0.06)*w + 0.5*w;
    hyper[6][1] = (2.0)*(0.06)*w + 0.5*w;
    hyper[6][2] = (4.0/3.0)*(0.06)*w + 0.5*w;
    hyper[6][3] = 2*(0.06)*w + 0.5*w;

    hyper[7][0] = 3*(0.06)*w + 0.5*w;
    hyper[7][1] = 0*(0.06)*w + 0.5*w;
    hyper[7][2] = 2*(0.06)*w + 0.5*w;
    hyper[7][3] = 2*(0.06)*w + 0.5*w;

    hyper[8][0] = 2*(0.06)*w + 0.5*w;
    hyper[8][1] = (2.0)*(0.06)*w + 0.5*w;
    hyper[8][2] = (4.0/3.0)*(0.06)*w + 0.5*w;
    hyper[8][3] = 2*(0.06)*w + 0.5*w;

    for(int i = 9; i<18; i++){
      hyper[i][0] = hyper[i-9][0];
      hyper[i][1] = hyper[i-9][1];
      hyper[i][2] = -1*hyper[i-9][2] + w;
      hyper[i][3] = hyper[i-9][3];
    }
    
    for(int i = 18; i<36; i++){
      hyper[i][0] = hyper[i-18][0];
      hyper[i][1] = hyper[i-18][1];
      hyper[i][2] = hyper[i-18][2];
      hyper[i][3] = -1.0*hyper[i-18][3] + w;
    }

    //set-up 4D vertices for hyper-tetrahedron (5 cell);
    /*
    hyper[0][0] = w*0.7;
    hyper[0][1] = w*0.7;
    hyper[0][2] = w*0.7;
    hyper[0][3] = w*(0.5 - 0.2*1.0/sqrt(5));
    
    hyper[1][0] = w*0.7;
    hyper[1][1] = w*0.3;
    hyper[1][2] = w*0.3;
    hyper[1][3] = w*(0.5 - 0.2*1.0/sqrt(5));

    hyper[2][0] = w*0.3;
    hyper[2][1] = w*0.7;
    hyper[2][2] = w*0.3;
    hyper[2][3] = w*(0.5 - 0.2*1.0/sqrt(5));

    hyper[3][0] = w*0.3;
    hyper[3][1] = w*0.3;
    hyper[3][2] = w*0.7;
    hyper[3][3] = w*(0.5 - 0.2*1.0/sqrt(5));

    hyper[4][0] = w*0.5;
    hyper[4][1] = w*0.5;
    hyper[4][2] = w*0.5;
    hyper[4][3] = w*(0.5 + 0.2*(sqrt(5) - 1.0/sqrt(5)));
    */

    //set-up 4D vertices for hyper-cube
    /*
    for(int i = 0; i<16; i++){
        if(isCube){
            hyper[i][0] = w*((0.3 + 0.4*(i%2)));
            if(i%4 < 2){
                hyper[i][1] = (0.3)*w;
            }else{
                hyper[i][1] = (0.7)*w;
            }
            if(i%8 < 4){
                hyper[i][2] = (0.3)*w;
            }else{
                hyper[i][2] = (0.7)*w;
            }
            if(i < 8){
                hyper[i][3] = (0.3)*w;
            }else{
                hyper[i][3] = (0.7)*w;
            }
        }else{
            hyper[i][0] = w*(random(0.0, RANDMAX)+ (float(1+((2*i)%4))/4.0));
            if(i%4 < 2){
                hyper[i][1] = (0.25 + random(0.0, RANDMAX))*w;
            }else{
                hyper[i][1] = (0.75 + random(0.0, RANDMAX))*w;
            }
            if(i%8 < 4){
                hyper[i][2] = (0.25 + random(0.0, RANDMAX))*w;
            }else{
                hyper[i][2] = (0.75 + random(0.0, RANDMAX))*w;
            }
            if(i < 8){
                hyper[i][3] = (0.25 + random(0.0, RANDMAX))*w;
            }else{
                hyper[i][3] = (0.75 + random(0.0, RANDMAX))*w;
            }

        }
    }
    */

    //rotate vertices by the 4 rotation matrices X,Y,Z,W
    /*
    for(int point = 0; point < 5; point++){
        //rotate3D(hyper[point], rotationX);
        //rotate3D(hyper[point], rotationY);
        //rotate3D(hyper[point], rotationZ);
        //rotate(hyper[point], rotationW);
    }
    */

    //set-up the 4D "infintessimal" rotation
    setRotation(theta1, theta2);
}

void setRotation(float th1, float th2){
  //set-up the 4D "infintessimal" rotation
    rotation[0][0] = cos(th1);
    rotation[0][1] = 0.0;
    rotation[0][2] = -sin(th1);
    rotation[0][3] = 0.0;
    rotation[1][0] = 0.0;
    rotation[1][1] = cos(th2);
    rotation[1][2] = 0.0;
    rotation[1][3] = -sin(th2);
    rotation[2][0] = sin(th1);
    rotation[2][1] = 0.0;
    rotation[2][2] = cos(th1);
    rotation[2][3] = 0.0;
    rotation[3][0] = 0.0;
    rotation[3][1] = sin(th2);
    rotation[3][2] = 0.0;
    rotation[3][3] = cos(th2);

    //rotate the axes of rotation by the rotationW matrix and rotationX&Y matrix
    rotation = matrixMult(rotationW, rotation);
    rotationW[0][3]*= -1.0;
    rotationW[3][0]*= -1.0;
    rotation = matrixMult(rotation, rotationW);
    rotationW[0][3]*= -1.0;
    rotationW[3][0]*= -1.0;
    
    rotation = matrixMult(rotationY, rotation);
    rotationY[0][2]*=-1.0;
    rotationY[2][0]*=-1.0;
    rotation = matrixMult(rotation, rotationY);
    rotationY[0][2]*=-1.0;
    rotationY[2][0]*=-1.0;
    
    rotation = matrixMult(rotationX, rotation);
    rotationX[1][2]*=-1.0;
    rotationX[2][1]*=-1.0;
    rotation = matrixMult(rotation, rotationX);
    rotationX[1][2]*=-1.0;
    rotationX[2][1]*=-1.0;
}

void projectAndUpdate(){
    for(int i = 0; i<36; i++){
        projection[i][0] = hyper[i][1];
        projection[i][1] = hyper[i][2];
        //float dist = sqrt(hyper[i][0]*hyper[i][0] + hyper[i][3]*hyper[i][3]);
        float dist = hyper[i][3];
        float alphaBright = map(dist, 50, 550, 0.0, 100.0);
        if(alphaBright<1.0) alphaBright = 1.0;
        if(alphaBright>99.0) alphaBright = 99.0;
        float hue = 0.0;
        if(i < 18){
          if((i%9)<4){
            hue = 180 + 30*(ceil(0.5*(i%9))%2);
          }else if((i%9)%2==0){
            hue = 210;
          }else{
            hue = 250;
          }
        }else{
          hue = 345 + (i%2)*10;
        }

        //if(i%18 > 8){
        //  vtxColors[i] = color(hue, 90, 20.0 + 0.3*(alphaBright), alphaBright);
        //}else{
          vtxColors[i] = color(hue, 90, 19.0 + 0.8*(alphaBright), alphaBright);
        //}
        if(i==31){
          //System.out.format("frame %d, pt: %d, hue: %f, alphaBright: %f%n", frameCount, i, hue, alphaBright);
        }
    }
}

void rotate3D(float[] vec, float[][] mat){
    float[] newvec  = {0.0, 0.0, 0.0, 0.0};
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
            newvec[i]+= (vec[j] - w/2.0)*mat[i][j];
        }
    }
    for(int i=0; i<4; i++){
        vec[i] = newvec[i]+(w/2.0);
    }
}

float[][] matrixMult(float[][] mat1, float[][] mat2){
    float[][] newMat = new float[4][4];
    for(int i = 0; i < 4; i++){
        for(int j = 0; j<4; j++){
            newMat[i][j] = 0.0;
            for(int k = 0; k<4; k++){
                newMat[i][j] += mat1[i][k]*mat2[k][j];
            }
        }
    }

    return newMat;            
}

void gradientLine(float x1, float y1, float z1, float x2, float y2, float z2, color a, color b) {
    float deltaX = x2-x1;
    float deltaY = y2-y1;
    float deltaZ = z2-z1;
    float d = dist(x1,y1,z1,x2,y2,z2);
    float tStep = 1.0;
    if(d > 0){
      tStep = 1.0/d;
    }
    for (float t = 0.0; t < 1.0; t += tStep) {
        fill(lerpColor(a, b, t));
        //float size = map(t, 0.0, 1.0, size1, size2);
        pushMatrix();
        translate(x1+t*deltaX, y1+t*deltaY, z1+t*deltaZ-300);
        ellipse(0, 0, 12, 12);
        popMatrix();
    }
}


void draw(){
  
    //project onto 2D and update colors
    projectAndUpdate();
    
    //fade out previous drawing
    float alphaVal = 12+11*cos(fade/2.0);
    //float alphaVal = 7.0;
    fill(0.0, 0.0, 0.0, alphaVal);
    pushMatrix();
    translate(0,0,450);
    hint(DISABLE_DEPTH_TEST);
    rect(0.0, 0.0, 600.0, 600.0);
    hint(ENABLE_DEPTH_TEST);
    popMatrix();

    pushMatrix();
    //translate(0.0, 0.0, -150.0);
    //draw gradient lines for eye
    for(int i = 0; i < 5; i++){
      gradientLine(hyper[i][0], hyper[i][1], hyper[i][2], hyper[(i+1)%5][0], hyper[(i+1)%5][1], hyper[(i+1)%5][2], vtxColors[i], vtxColors[(i+1)%5]);
      gradientLine(hyper[i][0], hyper[i][1], hyper[i][2], hyper[i+9][0], hyper[i+9][1], hyper[i+9][2], vtxColors[i], vtxColors[i+9]);
      gradientLine(hyper[i+9][0], hyper[i+9][1], hyper[i+9][2], hyper[(i+1)%5+9][0], hyper[(i+1)%5+9][1], hyper[(i+1)%5+9][2], vtxColors[i+9], vtxColors[(i+1)%5+9]);
      gradientLine(hyper[i+18][0], hyper[i+18][1], hyper[i+18][2], hyper[(i+1)%5+18][0], hyper[(i+1)%5+18][1], hyper[(i+1)%5+18][2], vtxColors[i+18], vtxColors[(i+1)%5+18]);
      gradientLine(hyper[i+18][0], hyper[i+18][1], hyper[i+18][2], hyper[i+27][0], hyper[i+27][1], hyper[i+27][2], vtxColors[i+18], vtxColors[i+27]);
      gradientLine(hyper[i+27][0], hyper[i+27][1], hyper[i+27][2], hyper[(i+1)%5+27][0], hyper[(i+1)%5+27][1], hyper[(i+1)%5+27][2], vtxColors[i+27], vtxColors[(i+1)%5+27]);
    }
    for(int i = 0; i < 2; i++){
      for(int j = 0; j < 2; j++){
        gradientLine(hyper[1+j*18+i*9][0], hyper[1+j*18+i*9][1], hyper[1+j*18+i*9][2], hyper[5+j*18+i*9][0], hyper[5+j*18+i*9][1], hyper[5+j*18+i*9][2], vtxColors[1+j*18+i*9], vtxColors[5+j*18+i*9]);
        gradientLine(hyper[5+j*18+i*9][0], hyper[5+j*18+i*9][1], hyper[5+j*18+i*9][2], hyper[6+j*18+i*9][0], hyper[6+j*18+i*9][1], hyper[6+j*18+i*9][2], vtxColors[5+j*18+i*9], vtxColors[6+j*18+i*9]);
        gradientLine(hyper[2+j*18+i*9][0], hyper[2+j*18+i*9][1], hyper[2+j*18+i*9][2], hyper[7+j*18+i*9][0], hyper[7+j*18+i*9][1], hyper[7+j*18+i*9][2], vtxColors[2+j*18+i*9], vtxColors[7+j*18+i*9]);
        gradientLine(hyper[7+j*18+i*9][0], hyper[7+j*18+i*9][1], hyper[7+j*18+i*9][2], hyper[8+j*18+i*9][0], hyper[8+j*18+i*9][1], hyper[8+j*18+i*9][2], vtxColors[7+j*18+i*9], vtxColors[8+j*18+i*9]);
      }
    }
    for(int i = 0; i<18; i++){
      if((i%9)!=5 && (i%9)!=7){
        gradientLine(hyper[i][0], hyper[i][1], hyper[i][2], hyper[i+18][0], hyper[i+18][1], hyper[i+18][2], vtxColors[i], vtxColors[i+18]);
      }
    }

    translate(0.5*w, 0.5*w, 0.0);
    fill(color(290, 90, 90, 100));
    sphere(1.5*(0.06)*w);
    fill(color(180, 90, 90, 10));
    sphere(1.8*(0.06)*w);
    popMatrix();
    
    //draw gradient lines between vertices of projected 5-cell
    /*
    for(int i = 0; i < 5; i++){
        for(int j = i; j < 5; j++){
            gradientLine(hyper[i][0], hyper[i][1], hyper[i][2], hyper[j][0], hyper[j][1], hyper[j][2], vtxColors[i], vtxColors[j]);
        }
    }
    */

    //draw gradient lines between vertices of projected hypercube
    /*
    gradientLine(hyper[0][0], hyper[0][1], hyper[0][2], hyper[1][0], hyper[1][1], hyper[1][2], vtxColors[0], vtxColors[1]);
    gradientLine(hyper[0][0], hyper[0][1], hyper[0][2], hyper[2][0], hyper[2][1], hyper[2][2], vtxColors[0], vtxColors[2]);
    gradientLine(hyper[0][0], hyper[0][1], hyper[0][2], hyper[4][0], hyper[4][1], hyper[4][2], vtxColors[0], vtxColors[4]);
    gradientLine(hyper[0][0], hyper[0][1], hyper[0][2], hyper[8][0], hyper[8][1], hyper[8][2], vtxColors[0], vtxColors[8]);
    gradientLine(hyper[1][0], hyper[1][1], hyper[1][2], hyper[9][0], hyper[9][1], hyper[9][2], vtxColors[1], vtxColors[9]);
    gradientLine(hyper[2][0], hyper[2][1], hyper[2][2], hyper[10][0], hyper[10][1], hyper[10][2], vtxColors[2], vtxColors[10]);
    gradientLine(hyper[3][0], hyper[3][1], hyper[3][2], hyper[1][0], hyper[1][1], hyper[1][2], vtxColors[3], vtxColors[1]);
    gradientLine(hyper[3][0], hyper[3][1], hyper[3][2], hyper[2][0], hyper[2][1], hyper[2][2], vtxColors[3], vtxColors[2]);
    gradientLine(hyper[3][0], hyper[3][1], hyper[3][2], hyper[7][0], hyper[7][1], hyper[7][2], vtxColors[3], vtxColors[7]);
    gradientLine(hyper[3][0], hyper[3][1], hyper[3][2], hyper[11][0], hyper[11][1], hyper[11][2], vtxColors[3], vtxColors[11]);
    gradientLine(hyper[4][0], hyper[4][1], hyper[4][2], hyper[12][0], hyper[12][1], hyper[12][2], vtxColors[4], vtxColors[12]);
    gradientLine(hyper[6][0], hyper[6][1], hyper[6][2], hyper[4][0], hyper[4][1], hyper[4][2], vtxColors[6], vtxColors[4]);
    gradientLine(hyper[6][0], hyper[6][1], hyper[6][2], hyper[2][0], hyper[2][1], hyper[2][2], vtxColors[6], vtxColors[2]);
    gradientLine(hyper[6][0], hyper[6][1], hyper[6][2], hyper[7][0], hyper[7][1], hyper[7][2], vtxColors[6], vtxColors[7]);
    gradientLine(hyper[6][0], hyper[6][1], hyper[6][2], hyper[14][0], hyper[14][1], hyper[14][2], vtxColors[6], vtxColors[14]);
    gradientLine(hyper[5][0], hyper[5][1], hyper[5][2], hyper[4][0], hyper[4][1], hyper[4][2], vtxColors[5], vtxColors[4]);
    gradientLine(hyper[5][0], hyper[5][1], hyper[5][2], hyper[1][0], hyper[1][1], hyper[1][2], vtxColors[5], vtxColors[1]);
    gradientLine(hyper[5][0], hyper[5][1], hyper[5][2], hyper[7][0], hyper[7][1], hyper[7][2], vtxColors[5], vtxColors[7]);
    gradientLine(hyper[5][0], hyper[5][1], hyper[5][2], hyper[13][0], hyper[13][1], hyper[13][2], vtxColors[5], vtxColors[13]);
    gradientLine(hyper[7][0], hyper[7][1], hyper[7][2], hyper[15][0], hyper[15][1], hyper[15][2], vtxColors[7], vtxColors[15]);
    gradientLine(hyper[8][0], hyper[8][1], hyper[8][2], hyper[9][0], hyper[9][1], hyper[9][2], vtxColors[8], vtxColors[9]);
    gradientLine(hyper[8][0], hyper[8][1], hyper[8][2], hyper[10][0], hyper[10][1], hyper[10][2], vtxColors[8], vtxColors[10]);
    gradientLine(hyper[8][0], hyper[8][1], hyper[8][2], hyper[12][0], hyper[12][1], hyper[12][2], vtxColors[8], vtxColors[12]);
    gradientLine(hyper[11][0], hyper[11][1], hyper[11][2], hyper[9][0], hyper[9][1], hyper[9][2], vtxColors[11], vtxColors[9]);
    gradientLine(hyper[11][0], hyper[11][1], hyper[11][2], hyper[10][0], hyper[10][1], hyper[10][2], vtxColors[11], vtxColors[10]);
    gradientLine(hyper[11][0], hyper[11][1], hyper[11][2], hyper[15][0], hyper[15][1], hyper[15][2], vtxColors[11], vtxColors[15]);
    gradientLine(hyper[14][0], hyper[14][1], hyper[14][2], hyper[12][0], hyper[12][1], hyper[12][2], vtxColors[14], vtxColors[12]);
    gradientLine(hyper[14][0], hyper[14][1], hyper[14][2], hyper[10][0], hyper[10][1], hyper[10][2], vtxColors[14], vtxColors[10]);
    gradientLine(hyper[14][0], hyper[14][1], hyper[14][2], hyper[15][0], hyper[15][1], hyper[15][2], vtxColors[14], vtxColors[15]);
    gradientLine(hyper[13][0], hyper[13][1], hyper[13][2], hyper[12][0], hyper[12][1], hyper[12][2], vtxColors[13], vtxColors[12]);
    gradientLine(hyper[13][0], hyper[13][1], hyper[13][2], hyper[9][0], hyper[9][1], hyper[9][2], vtxColors[13], vtxColors[9]);
    gradientLine(hyper[13][0], hyper[13][1], hyper[13][2], hyper[15][0], hyper[15][1], hyper[15][2], vtxColors[13], vtxColors[15]);
    */
    //rotate hypersurface to next step
    float th = (0.01399)*(1-cos(2.0*PI*float(frameCount)/628.0))+0.001;
    setRotation(th,th); 
    for(int point = 0; point <36; point++){
        rotate3D(hyper[point], rotation);
    }
    //increment fade variable;
    fade += 0.01;
    //println(frameCount);
    if(frameCount<=1256){
      saveFrame("./tmp/hyperv5-2_####.png");
    }else if(frameCount>1256){
      noLoop();
    }
    
}