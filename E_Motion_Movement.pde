import SimpleOpenNI.*;
SimpleOpenNI context;
Particle[] flow = new Particle[3000];
  // global variables to influence the movement of all particles
float globalX, globalY;
boolean tracking;

 
int opaq = 255;
int x, y;
int[] userMap;

float reScale;
int kinWidth = 640;
int kinHeight = 480;

color red = #8B0000;
color gold = #DAA520;
color black = #000000;
color indigo = #4b0082;
color aqua = #eee8aa;
color brown = #a3692d;
color[] colors = {
  red, black, indigo
};
 
void setup() {
 
 size(displayWidth, displayHeight);
  context = new SimpleOpenNI(this);
  
    
  
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

  for (int i = 0; i<flow.length;i++) {
    flow[i] = new Particle(i/10000.0);
  }

  background(255);

}

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
             fill(255,255,255,20);
  rect(0,0,width,height);
  
}

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
 

 

