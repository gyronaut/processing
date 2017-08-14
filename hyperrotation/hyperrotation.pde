float hyper[][] = new float[16][4];
float rotation[][] = new float[4][4];
float projection[][] = new float[16][2];
float rotationX[][] = new float[4][4];
float rotationY[][] = new float[4][4];
float rotationZ[][] = new float [4][4];
float rotationW[][] = new float [4][4];
color vtxColors[] = new color[16];

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
    background(0.0);
    size(600, 600);
    colorMode(HSB, 360, 100, 100);
    noStroke();

    //setup Colors
    for(int i = 0; i< 16; i++){
        vtxColors[i] = color(170 + 5*i, 100 - (3.75*i), 100-(i*3.75));
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

    //set-up 4D vertices
    for(int i = 0; i<16; i++){
        if(isCube){
            hyper[i][0] = w*((float(1+((2*i)%4))/4.0));
            if(i%4 < 2){
                hyper[i][1] = (0.25)*w;
            }else{
                hyper[i][1] = (0.75)*w;
            }
            if(i%8 < 4){
                hyper[i][2] = (0.25)*w;
            }else{
                hyper[i][2] = (0.75)*w;
            }
            if(i < 8){
                hyper[i][3] = (0.25)*w;
            }else{
                hyper[i][3] = (0.75)*w;
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

    //rotate vertices by the 3 rotation matrices X,Y,Z  
    for(int point = 0; point < 16; point++){
        rotate(hyper[point], rotationX);
        rotate(hyper[point], rotationY);
        rotate(hyper[point], rotationZ);
        rotate(hyper[point], rotationW);
    }

    //set-up the 4D "infintessimal" rotation
    rotation[0][0] = cos(theta1);
    rotation[0][1] = 0.0;
    rotation[0][2] = -sin(theta1);
    rotation[0][3] = 0.0;
    rotation[1][0] = 0.0;
    rotation[1][1] = cos(theta2);
    rotation[1][2] = 0.0;
    rotation[1][3] = -sin(theta2);
    rotation[2][0] = sin(theta1);
    rotation[2][1] = 0.0;
    rotation[2][2] = cos(theta1);
    rotation[2][3] = 0.0;
    rotation[3][0] = 0.0;
    rotation[3][1] = sin(theta2);
    rotation[3][2] = 0.0;
    rotation[3][3] = cos(theta2);

    //rotate the axes of rotation by the rotationW matrix?
    rotation = matrixMult(rotationW, rotation);
    rotationW[0][3]*= -1.0;
    rotationW[3][0]*= -1.0;
    rotation = matrixMult(rotation, rotationW);
}

void projectAndUpdate(){
    for(int i = 0; i<16; i++){
        projection[i][0] = hyper[i][1];
        projection[i][1] = hyper[i][2];
        float dist = sqrt(hyper[i][0]*hyper[i][0] + hyper[i][3]*hyper[i][3]);
        float alphaBright = map(dist, 150.0, 600.0*sqrt(2.0)-150.0, 0.0, 100.0);
        if(alphaBright<1.0) alphaBright = 1.0;
        if(alphaBright>99.0) alphaBright = 99.0;
        float hue = map(dist, 150.0, 600.0*sqrt(2.0)-150.0, 0, 250);
        if(hue < 0.0) hue = 0.0;
        if(hue > 250) hue = 250.0;
        vtxColors[i] = color(hue, 75, 50+(0.5*alphaBright), 20+(0.8*alphaBright));
    }
}

void rotate(float[] vec, float[][] mat){
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

void gradientLine(float x1, float y1, float x2, float y2, color a, color b, float size1, float size2) {
    size1 = abs(size1/600.0)*15.0+5.0;
    if(size1 < 5.0) size1=5.0;
    if(size1 > 20.0) size1=20.0;
    size2 = abs(size2/600.0)*15.0+5.0;
    if(size2 < 5.0) size2 = 5.0;
    if(size2 > 20.0) size2 = 20.0;
    float deltaX = x2-x1;
    float deltaY = y2-y1;
    float tStep = 1.0/dist(x1, y1, x2, y2);
    for (float t = 0.0; t < 1.0; t += tStep) {
        fill(lerpColor(a, b, t));
        float size = map(t, 0.0, 1.0, size1, size2);
        ellipse(x1+t*deltaX,  y1+t*deltaY, size, size);
    }
}


void draw(){
    //fade out previous drawing
    //float alphaVal = 30+20*cos(fade);
    float alphaVal = 50.0;
    fill(0.0, 0.0, 0.0, alphaVal);
    rect(0.0, 0.0, 600.0, 600.0);
    //project onto 2D and update colors
    projectAndUpdate();

    //draw gradient lines between vertices of projected hypersurface
    gradientLine(projection[0][0], projection[0][1], projection[1][0], projection[1][1], vtxColors[0], vtxColors[1], hyper[0][3], hyper[1][3]);
    gradientLine(projection[0][0], projection[0][1], projection[2][0], projection[2][1], vtxColors[0], vtxColors[2], hyper[0][3], hyper[2][3]);
    gradientLine(projection[0][0], projection[0][1], projection[4][0], projection[4][1], vtxColors[0], vtxColors[4], hyper[0][3], hyper[4][3]);
    gradientLine(projection[0][0], projection[0][1], projection[8][0], projection[8][1], vtxColors[0], vtxColors[8], hyper[0][3], hyper[8][3]);
    gradientLine(projection[1][0], projection[1][1], projection[9][0], projection[9][1], vtxColors[1], vtxColors[9], hyper[1][3], hyper[9][3]);
    gradientLine(projection[2][0], projection[2][1], projection[10][0], projection[10][1], vtxColors[2], vtxColors[10], hyper[2][3], hyper[10][3]);
    gradientLine(projection[3][0], projection[3][1], projection[1][0], projection[1][1], vtxColors[3], vtxColors[1], hyper[3][3], hyper[1][3]);
    gradientLine(projection[3][0], projection[3][1], projection[2][0], projection[2][1], vtxColors[3], vtxColors[2], hyper[3][3], hyper[2][3]);
    gradientLine(projection[3][0], projection[3][1], projection[7][0], projection[7][1], vtxColors[3], vtxColors[7], hyper[3][3], hyper[7][3]);
    gradientLine(projection[3][0], projection[3][1], projection[11][0], projection[11][1], vtxColors[3], vtxColors[11], hyper[3][3], hyper[11][3]);
    gradientLine(projection[4][0], projection[4][1], projection[12][0], projection[12][1], vtxColors[4], vtxColors[12], hyper[4][3], hyper[12][3]);
    gradientLine(projection[6][0], projection[6][1], projection[4][0], projection[4][1], vtxColors[6], vtxColors[4], hyper[6][3], hyper[4][3]);
    gradientLine(projection[6][0], projection[6][1], projection[2][0], projection[2][1], vtxColors[6], vtxColors[2], hyper[6][3], hyper[2][3]);
    gradientLine(projection[6][0], projection[6][1], projection[7][0], projection[7][1], vtxColors[6], vtxColors[7], hyper[6][3], hyper[7][3]);
    gradientLine(projection[6][0], projection[6][1], projection[14][0], projection[14][1], vtxColors[6], vtxColors[14], hyper[6][3], hyper[14][3]);
    gradientLine(projection[5][0], projection[5][1], projection[4][0], projection[4][1], vtxColors[5], vtxColors[4], hyper[5][3], hyper[4][3]);
    gradientLine(projection[5][0], projection[5][1], projection[1][0], projection[1][1], vtxColors[5], vtxColors[1], hyper[5][3], hyper[1][3]);
    gradientLine(projection[5][0], projection[5][1], projection[7][0], projection[7][1], vtxColors[5], vtxColors[7], hyper[5][3], hyper[7][3]);
    gradientLine(projection[5][0], projection[5][1], projection[13][0], projection[13][1], vtxColors[5], vtxColors[13], hyper[5][3], hyper[13][3]);
    gradientLine(projection[7][0], projection[7][1], projection[15][0], projection[15][1], vtxColors[7], vtxColors[15], hyper[7][3], hyper[15][3]);
    gradientLine(projection[8][0], projection[8][1], projection[9][0], projection[9][1], vtxColors[8], vtxColors[9], hyper[8][3], hyper[9][3]);
    gradientLine(projection[8][0], projection[8][1], projection[10][0], projection[10][1], vtxColors[8], vtxColors[10], hyper[8][3], hyper[10][3]);
    gradientLine(projection[8][0], projection[8][1], projection[12][0], projection[12][1], vtxColors[8], vtxColors[12], hyper[8][3], hyper[12][3]);
    gradientLine(projection[11][0], projection[11][1], projection[9][0], projection[9][1], vtxColors[11], vtxColors[9], hyper[11][3], hyper[9][3]);
    gradientLine(projection[11][0], projection[11][1], projection[10][0], projection[10][1], vtxColors[11], vtxColors[10], hyper[11][3], hyper[10][3]);
    gradientLine(projection[11][0], projection[11][1], projection[15][0], projection[15][1], vtxColors[11], vtxColors[15], hyper[11][3], hyper[15][3]);
    gradientLine(projection[14][0], projection[14][1], projection[12][0], projection[12][1], vtxColors[14], vtxColors[12], hyper[14][3], hyper[12][3]);
    gradientLine(projection[14][0], projection[14][1], projection[10][0], projection[10][1], vtxColors[14], vtxColors[10], hyper[14][3], hyper[10][3]);
    gradientLine(projection[14][0], projection[14][1], projection[15][0], projection[15][1], vtxColors[14], vtxColors[15], hyper[14][3], hyper[15][3]);
    gradientLine(projection[13][0], projection[13][1], projection[12][0], projection[12][1], vtxColors[13], vtxColors[12], hyper[13][3], hyper[12][3]);
    gradientLine(projection[13][0], projection[13][1], projection[9][0], projection[9][1], vtxColors[13], vtxColors[9], hyper[13][3], hyper[9][3]);
    gradientLine(projection[13][0], projection[13][1], projection[15][0], projection[15][1], vtxColors[13], vtxColors[15], hyper[13][3], hyper[15][3]);

    //rotate hypersurface to next step
    for(int point = 0; point <16; point++){
        rotate(hyper[point], rotation);
    }
    //increment fade variable;
    fade += 0.01;
    if(frameCount<=628){
      saveFrame("./tmp/hyperv2-0_####.png");
    }else if(frameCount>628){
      noLoop();
    }
}