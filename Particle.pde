 int[] prevFrame;
 
class Particle {
  int index; 
  float id;
  float x, y, s, sz, d;
  float xp, yp;
  color col; 
  float a = PI/2;

  Particle (float id) {
    this.id = id;
  
    s = random(2, 8);
    sz = random(1, 6);
   
    col = colors[int(random(colors.length))];

  }
 
  void update() {
  
  

    
    id+=0.01;
    
    d = random(noise(id, x/globalY, y/globalY)-0.5)*globalX;
 
    x += cos(radians(d))*s;
    y += sin(radians(d))*s;
    
    if (x<0) x = xp =random(640);
    if (x>640) x =xp =  random(640);
    if (y<0) y = yp = random(480);
    if (y>480) y = yp = random(480);
    
    index = int(y)*640+int(x);
    if (index>=userMap.length||index<0) {
      return;
    }
    if (id > 0) {          
      if (userMap[index] != 0) {
      
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
