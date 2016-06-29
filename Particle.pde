/**The Particle Class which determines the speed, location, size and direction of the particles that are moving to
create a movement painting**/
 
class Particle {
  int index; 
  float id;
  //location, speed, size, and direction
  float x, y, s, sz, d;
  //ne wlocation
  float xp, yp;
  color col; 
  float a = PI/2;


  Particle (float id) {
    this.id = id;
  
   //the randomly size and speed of the particles
    s = random(2, 8);
    sz = random(1, 6);
   
   // will randomly take in all the colors- red, indigo, and black
    col = colors[int(random(colors.length))];

  }
 
  void update() {
  
  

    
    id+=0.01;
    
    //direction of the particles
    d = random(noise(id, x/globalY, y/globalY)-0.5)*globalX;
 
   // location
    x += cos(radians(d))*s;
    y += sin(radians(d))*s;
    
    //movement of the particles throughout the kinect depth
    if (x<0) x = xp =random(640);
    if (x>640) x =xp =  random(640);
    if (y<0) y = yp = random(480);
    if (y>480) y = yp = random(480);
    
    //Create the body silhouette  with the Kinect and Processing library
    index = int(y)*640+int(x);
    if (index>=userMap.length||index<0) {
      return;
    }
    //when you capture a user
    if (id > 0) {          
      if (userMap[index] != 0) {
      
        //you will capture the body and create visual painting
        stroke(col , opaq);
        strokeWeight(sz);
        point(x, y);
      
      }
    }
    else {
      fill(col, opaq);
    
    }
  }
}
