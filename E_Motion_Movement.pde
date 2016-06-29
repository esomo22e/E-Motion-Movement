import SimpleOpenNI.*;
SimpleOpenNI context;

Particle[] flow = new Particle[3000];

// global variables to influence the movement of all particles
float globalX, globalY;
boolean tracking;

//visibility of the color
int opaq = 255;
int x, y;
int[] userMap;


float reScale;

//Kinect display resolution
int kinWidth = 640;
int kinHeight = 480;

//The color of the paricles red, black, and indigo
color red = #8B0000;
color black = #000000;
color indigo = #4b0082;

color[] colors = {
  red, black, indigo
};
 
 
void setup() {
 
 
 size(displayWidth, displayHeight);
  context = new SimpleOpenNI(this);
  
  
  //to make sure that the Kinect is connected
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!");
    exit();
    return;
  }
  context.enableDepth();
  context.enableUser();
  context.setMirror(true);
 
  
  reScale = (float) width/kinWidth;

  //to showcase the particles when capturing 
  for (int i = 0; i<flow.length;i++) {
    flow[i] = new Particle(i/10000.0);
  }

  
  background(255);

}

//make the Kinect depth fullscreen
boolean sketchFullScreen(){
  return true;
}
 
void draw() {
  


  context.update();
  userMap = context.userMap();

  drawFlowField();
  

}

void drawFlowField(){
  //center and reScale from Kinect to custom dimensions
  translate(0, (height-kinHeight*reScale)/2);
  scale(reScale);
  
  //set global variables that influence the particle flow's movement
  globalX = noise(frameCount * 0.01) * width/2 + width/4;
  globalY = noise(frameCount * 0.005 + 5) * height;
    
  //update and display all particles in the flow
  for (Particle f : flow) {
    f.update();
  }
  
  //In order to cause a delay witht the particles
  fill(255,255,255,20);
  rect(0,0,width,height);
  
}

/**If you presssed 'S' then you are able to save a motion picture **/
void keyPressed(){
  
  if(key == 's' || key == 'S'){
    saveFrame("motion-###.png");
  }
}
 
void onNewUser(SimpleOpenNI curkinect, int userId){
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  tracking = true;
  println("tracking");
  curkinect.startTrackingSkeleton(userId);
}
 
void onLostUser(SimpleOpenNI curkinect, int userId){
  println("onLostUser - userId: " + userId);
}
 
void onVisibleUser(SimpleOpenNI curkinect, int userId){
  println("onVisibleUser - userId: " + userId);
}
 

 

