import geomerative.*;

RShape path_00,path_01,path_02,path_03,path_04,path_05,
       path_06,path_07,path_08,bound_01,bound_02,bound_03,
       bound_04,bound_05;
       
RPoint[] points_00,points_01,points_02,points_03,points_04
        ,points_05,points_06,points_07,points_08,bPoints_01,
        bPoints_02,bPoints_03,bPoints_04,bPoints_05;

PImage trafficMap;

int[] p            = new int[9];
int   nPoints      = 4096;
float complexity   = 8;
float maxMass      = .8;
float timeSpeed    = .02;
float phase        =  TWO_PI;
float windSpeed    = 40;
int   step         = 10;

float[] pollenMass;
float[][] points;

boolean isPathCovered = false;

float f            = 0;
void setup(){
  size(1000,1000);   
  smooth();
  frameRate(25); 
  
  points      = new float[nPoints][2];
  pollenMass  = new float[nPoints];
  for(  int i = 0; i < nPoints; i++)
   {
      points[i] = new float[]{400+random(-5,5),80+random(-5,5)};
      pollenMass[i] = random(0,maxMass);
   } 
  noiseDetail(14);
  
  RG.init(this);
 
  path_00 = RG.loadShape("path_00.svg");
  path_01 = RG.loadShape("path_01.svg");
  path_02 = RG.loadShape("path_02.svg");
  path_03 = RG.loadShape("path_03.svg");
  path_04 = RG.loadShape("path_04.svg");
  path_05 = RG.loadShape("path_05.svg");
  path_06 = RG.loadShape("path_06.svg");
  path_07 = RG.loadShape("path_07.svg");
  path_08 = RG.loadShape("path_08.svg");
 
  bound_01 = RG.loadShape("bound_01.svg");
  bound_02 = RG.loadShape("bound_02.svg");
  bound_03 = RG.loadShape("bound_03.svg");
  bound_04 = RG.loadShape("bound_04.svg");
  bound_05 = RG.loadShape("bound_05.svg");

  for (int i = 0; i < 9; i++){
     p[i] = 0;
  } 
  
  trafficMap = loadImage("map.jpeg");
  trafficMap.resize(1000,1000);
  image(trafficMap, 0, 0);
 
}

void draw(){

 /*  DRAWING SVG FILE  */
   RG.shape(bound_01);
   RG.shape(bound_02);
   RG.shape(bound_03);
   RG.shape(bound_04);
   RG.shape(bound_05);

  
   /*  GET POINTS OF SVG  */
  points_00 = path_00.getPoints();
  points_01 = path_01.getPoints();
  points_02 = path_02.getPoints();
  points_03 = path_03.getPoints();
  points_04 = path_04.getPoints();
  points_05 = path_05.getPoints();
  points_06 = path_06.getPoints();  
  points_07 = path_07.getPoints();
  points_08 = path_08.getPoints();
  
  bPoints_01 = bound_01.getPoints();
  bPoints_02 = bound_02.getPoints();
  bPoints_03 = bound_03.getPoints();
  bPoints_04 = bound_04.getPoints();
  bPoints_05 = bound_05.getPoints();
  
  fill(0);
  pathFollower();
  
 
  //println(i);
 
}
void keyPressed(){
 if(key == 'a'){
  index++;
 } 
}
void pathFollower(){
  fill(255,0,0,80);
  noStroke(); 
  if(p[0] != points_00.length) p[0]++;
  ellipse(points_00[points_00.length-p[0]].x, points_00[points_00.length-p[0]].y,5,5);

  if(p[1] < points_01.length) p[1]++;
  ellipse(points_01[points_01.length-p[1]].x, points_01[points_01.length-p[1]].y,5,5);   
 
  if(p[2] < points_02.length) p[2]++;
  ellipse(points_02[points_02.length-p[2]].x, points_02[points_02.length-p[2]].y,5,5);

  if(p[1] > 87 && p[3] < points_03.length ){
     ellipse(points_03[p[3]].x, points_03[p[3]].y,5,5); 
     p[3]++;
  }
  
  if(p[4] < points_04.length) p[4]++;
  ellipse(points_04[points_04.length-p[4]].x, points_04[points_04.length-p[4]].y,5,5);  

  if(p[4] == points_04.length && p[5] < points_05.length ){
     ellipse(points_05[p[5]].x, points_05[p[5]].y,5,5); 
     p[5]++;
  }
 
  if(p[5] > 62 && p[6] < points_06.length ){
     ellipse(points_06[p[6]].x, points_06[p[6]].y,5,5); 
     p[6]++;
  }
  
  if(p[8] > 25 && p[7] < points_07.length ){
     ellipse(points_07[p[7]].x, points_07[p[7]].y,5,5); 
     p[7]++;
  }
  
  if(p[1] > 208 && p[8] < points_08.length ){
      ellipse(points_08[p[8]].x, points_08[p[8]].y,5,5); 
     p[8]++;
  }
  
  if(p[0] > points_00.length-1 && p[1] > points_01.length-1 && p[2] > points_02.length-1 && p[3] > points_03.length-1 &&
    p[4] > points_04.length-1 && p[5] > points_05.length-1 && p[6] > points_06.length-1 && p[7] > points_07.length-1 && p[8] > points_08.length-1){
      
      if(!isPathCovered){
         for(int i = 0; i < nPoints; i++){
            if(i < 768){
               int r=(int) random(0,points_00.length);
               points[i][0] = points_00[r].x;
               points[i][1] = points_00[r].y;;  
            }else if(i < 1536){
               int r=(int) random(0,points_01.length);
               points[i][0] = points_01[r].x;
               points[i][1] = points_01[r].y; 
             
            }else if(i < 2048){
               int r=(int) random(0,points_02.length);
               points[i][0] = points_02[r].x;
               points[i][1] = points_02[r].y;  
             
            }else if(i < 2348){
               int r=(int) random(0,points_03.length);
               points[i][0] = points_03[r].x;
               points[i][1] = points_03[r].y;  
             
            }else if(i < 2604){
               int r=(int) random(0,points_04.length);
               points[i][0] = points_04[r].x;
               points[i][1] = points_04[r].y;  
             
            }else if(i < 2860){
               int r=(int) random(0,points_05.length);
               points[i][0] = points_05[r].x;
               points[i][1] = points_05[r].y;  
             
            }else if(i < 3360 ){
               int r=(int) random(0,points_06.length);
               points[i][0] = points_06[r].x;
               points[i][1] = points_06[r].y;  
             
            }else if(i < 3860){
               int r=(int) random(0,points_07.length);
               points[i][0] = points_07[r].x;
               points[i][1] = points_07[r].y; 
             
            }else if(i < 4096){
               int r=(int) random(0,points_08.length);
               points[i][0] = points_08[r].x;
               points[i][1] = points_08[r].y;           
            }        
         }
      }
     isPathCovered = true;   
    spreadingParticle();
  }
 
}

void spreadingParticle()
{
  float t = frameCount * timeSpeed;
  stroke(255,0,0,30);
  
  for (int i = 0; i < nPoints; i++){  
    float x = points[i][0];
    float y = points[i][1];
      
    float normx = norm(x, 0, width);
    float normy = norm(y, 0,height);
    float u = noise(t + phase, normx * complexity + phase, normy * complexity + phase);
    float v = noise(t - phase, normx * complexity - phase, normy * complexity + phase);
    float speed = ( 1 + noise( t, u, v)) / pollenMass[i];
    float dirX = lerp( -speed, speed, u);
    float dirY = lerp( -speed, speed, v);
 
      
    if ( x < 0 )
      x = width -1;
    else if ( x >= width)
      x = 0;
        
    if( y < 0 )
      y = height -1;
    else if ( y >= width)
      y = 0;
      
    if( x > 450 && y > 400 && y < 875){
       for( int idx = 0; idx < bPoints_01.length; idx++){
         PVector boundPoint =  new PVector(bPoints_01[idx].x,bPoints_01[idx].y);
         PVector p = new PVector(x,y);
          if(PVector.dist(boundPoint, p) < 10.0){
           y = random(0,height);
           x = 0;
          }
       }
       for( int idx = 0; idx < bPoints_02.length; idx++){
         PVector boundPoint =  new PVector(bPoints_02[idx].x,bPoints_02[idx].y);
         PVector p = new PVector(x,y);
          if(PVector.dist(boundPoint, p) < 10.0){
           y = random(0,height);
           x = 0;
          }
       }
    }
    if( x > 350 && y > 875){
       for( int idx = 0; idx < bPoints_03.length; idx++){
         PVector boundPoint =  new PVector(bPoints_03[idx].x,bPoints_03[idx].y);
         PVector p = new PVector(x,y);
          if(PVector.dist(boundPoint, p) < 10.0){
           y = 0;
           x = random(0,width);
          }
       }
       for( int idx = 0; idx < bPoints_04.length; idx++){
         PVector boundPoint =  new PVector(bPoints_04[idx].x,bPoints_04[idx].y);
         PVector p = new PVector(x,y);
          if(PVector.dist(boundPoint, p) < 10.0){
           y = 0;
           x = random(0,width);
          }
       }
    }
    
     if( x > 800 && y > 875){
       for( int idx = 0; idx < bPoints_05.length; idx++){
         PVector boundPoint =  new PVector(bPoints_05[idx].x,bPoints_05[idx].y);
         PVector p = new PVector(x,y);
          if(PVector.dist(boundPoint, p) < 10.0){
           y = random(0,height);
           x = 0;
          }
       }
    }   
    
    x += dirX;
    y += dirY;
    point( x, y);
  
    points[i][0] = x;
    points[i][1] = y;    
  } 
}
void mousePressed(){
  
}
