Camara cam;
boolean change; //cambio de menu previo a vistas

int ang = 0, colorVal = 0, colorR = 0, colorG = 0, colorB = 0, numOfLights = -1, size;
float tras = 0;
PShape chair, table, platform, skull, eye;
PShape walls, floor, roof;
PImage wallsImage, floorImage, roofImage;

ArrayList<ColorItem> lightsList;

void setup(){
  wallsImage = loadImage("Objects/pared.png");//https://www.teleadhesivo.com/es/img/fomb006-png/folder/products-detalle-png/fotomurales-textura-pared-de-piedra.png
  floorImage = loadImage("Objects/suelo.jpg");//https://www.albaniles.org/wp-content/uploads/2018/03/gotel%C3%A9-1024x673.jpg
  roofImage = loadImage("Objects/techo.jpg");//https://i.pinimg.com/originals/53/3d/62/533d62e0c2259c5f8340372e824e862e.jpg
  size(1500,1000, P3D);
  cam = new Camara(3.0, 100);
  createWallsAndFloorRoof();
  chair = loadShape("Objects/Chair/Chair.obj");//https://free3d.com/es/modelo-3d/chair-16205.html
  table = loadShape("Objects/Tabel/table.obj");//https://free3d.com/es/modelo-3d/cinema4d-table-66762.html
  skull = loadShape("Objects/Skull/12140_Skull_v3_L2.obj"); //https://free3d.com/es/modelo-3d/skull-v3--785914.html
  platform = loadShape("Objects/ceremonial/17002_ceremonial_platform_with_altar_v1.obj");//https://free3d.com/es/modelo-3d/ceremonial-platform-with-altar-v1--222595.html
  eye = loadShape("Objects/Eye/eyeball.obj");//https://free3d.com/3d-model/eyeball--33237.html
  lightsList = new ArrayList<ColorItem>();
  sphereDetail(60);
}

void draw(){
  if(change){
    background(80);
    lightSettings();
    displayWallsAndFloorRoof();
    display3DForms();
    cam.display();
  } else{
    background(0);
    showMenu();
  }
}

void createWallsAndFloorRoof(){
  size = 2000;
  walls = createShape();
  walls.beginShape(QUAD_STRIP);
  walls.textureMode(NORMAL);
  textureWrap(REPEAT);
  walls.texture(wallsImage);
  walls.vertex((width/2.0)-size,(height/2.0)-size,-size,0,0);
  walls.vertex((width/2.0)-size,(height/2.0)+size,-size,1,0);
  walls.vertex((width/2.0)+size,(height/2.0)-size,-size,1,1);
  walls.vertex((width/2.0)+size,(height/2.0)+size,-size,0,1);
  walls.vertex((width/2.0)+size,(height/2.0)-size,+size,0,0);
  walls.vertex((width/2.0)+size,(height/2.0)+size,+size,1,0);
  walls.vertex((width/2.0)-size,(height/2.0)-size,+size,1,1);
  walls.vertex((width/2.0)-size,(height/2.0)+size,+size,0,1);
  walls.vertex((width/2.0)-size,(height/2.0)-size,-size,0,0);
  walls.vertex((width/2.0)-size,(height/2.0)+size,-size,1,0);
  walls.endShape();  
  
  floor = createShape();
  floor.beginShape(QUAD);
  floor.textureMode(NORMAL);
  textureWrap(REPEAT);
  floor.texture(floorImage);
  floor.vertex((width/2.0)-size,(height/2.0)+size,-size,0,0);
  floor.vertex((width/2.0)-size,(height/2.0)+size,+size,1,0);
  floor.vertex((width/2.0)+size,(height/2.0)+size,+size,1,1);
  floor.vertex((width/2.0)+size,(height/2.0)+size,-size,0,1);
  floor.endShape();
  
  roof = createShape();
  roof.beginShape(QUAD);
  roof.textureMode(NORMAL);
  textureWrap(REPEAT);
  roof.texture(roofImage);
  roof.vertex((width/2.0)-size,(height/2.0)-size,-size,0,0);
  roof.vertex((width/2.0)-size,(height/2.0)-size,+size,1,0);
  roof.vertex((width/2.0)+size,(height/2.0)-size,+size,1,1);
  roof.vertex((width/2.0)+size,(height/2.0)-size,-size,0,1);
  roof.endShape();
  
}

void displayWallsAndFloorRoof(){
  shape(walls);
  shape(floor);
  shape(roof);
}

void display3DForms(){
  pushMatrix();
  translate((width/2.0), height+1200, -550);
  scale(10);
  rotateX(PI);
  rotateY(PI/2.0);
  shape(table);
  popMatrix();
  
  pushMatrix();
  translate((width/2.0), height+1500, -1550);
  scale(35);
  rotateX(PI);
  shape(chair);
  popMatrix();
  
  pushMatrix();
  translate((width/2.0)+500, height+690, -600);
  scale(0.1);
  rotateX(PI/2.0);
  shape(platform);
  popMatrix();
  
  pushMatrix();
  translate((width/2.0)+500, (height/2.0)+1000, -600);
  scale(10);
  rotateX(PI/2.0);
  rotateZ(radians(ang));
  shape(skull);
  popMatrix();
  
  pushMatrix();
  translate(((width/2.0)-500)+100*cos(tras), ((height/2.0)+1140), (-600)+100*sin(tras));
  scale(20);
  rotateY(radians(-ang));
  rotateX(radians(-ang));
  shape(eye);
  tras += 0.01;
  if(tras > 360){tras = 0;}
  popMatrix();
  ang +=1;
  if(ang>360) ang=0;
}

void lightSettings(){
  lights();
  ambientLight(colorR,colorG,colorB);
  for(int i = 0; i < lightsList.size(); i++){
    directionalLight(lightsList.get(i).getR(), lightsList.get(i).getG(), lightsList.get(i).getB(), lightsList.get(i).getX(), lightsList.get(i).getY(), lightsList.get(i).getZ());
    pushMatrix();
      translate(lightsList.get(i).getX(), lightsList.get(i).getY(), lightsList.get(i).getZ());
      noStroke();
      specular(100, 100, 100);
      emissive(lightsList.get(i).getB(), lightsList.get(i).getR(), lightsList.get(i).getG());
      shininess(lightsList.get(i).getS());
      sphere(30);
    popMatrix();
  }
}

void showMenu(){
  camera(0,0,500,0,0,0,0,1,0);
  text("Usa las flechas del teclado para rotar la camara en las cuatro direcciones",-250,-200);
  text("Espacio para avanzar, shift para retroceder",-250,-170);
  text("Tabulador para cambiar el color de la luz ambiente aleatoriamente",-250,-140);
  text("Usa las teclas + y - para la aumentar o disminuir el numero de luces aleatorias(minimo:0 | maximo:7)",-250,-110);
  text("Se generara una esfera donde se cree la nueva luz",-250,-80);
  text("Retroceso para resetear vista",-250,-50);
  text("Pulsa ENTER para empezar y para volver a mostrar este menu",-250,-20);
  
}



void keyPressed(){
  if (keyCode == LEFT){
    cam.camrotateX(-1);
  }
  if (keyCode == RIGHT){
    cam.camrotateX(1);
  }
  if (keyCode == UP){
    cam.camrotateY(-1);
  }
  if (keyCode == DOWN){
    cam.camrotateY(1);
  }
  if (key == ' '){
    cam.moveZ(1);
  }
  if (keyCode == SHIFT){
    cam.moveZ(-1);
  }
  
  if (keyCode == ENTER){
    change = !change;
  }
  
  if (keyCode == BACKSPACE){
    cam.reset();
    while(numOfLights > -1){
      popLights();
      numOfLights -=1;
    }
    colorR = 0; colorG = 0; colorB = 0;
    
  }
  
  if (keyCode == TAB){
    colorR = (int)random(0,255); colorG = (int)random(0,255); colorB = (int)random(0,255);

  }
  if (key == '+' && numOfLights < 6){
    numOfLights +=1;
    pushLights();
  }
  
  if (key == '-' && numOfLights > -1){
    popLights();
    numOfLights -=1;
  }
}

void pushLights(){
  lightsList.add(new ColorItem((int)random(0,255), (int)random(0,255), (int)random(0,255), (int)random((width/2.0)-size+20,(width/2.0)+size-20), (int)random((height/2.0)-size+20,(height/2.0)+size-20), (int)random(-size+20,size-20), (int)random(1,100)));
}

void popLights(){
  lightsList.remove(numOfLights);
}

void keyReleased(){
  if (keyCode == LEFT){
    cam.camrotateX(0);
  }
  if (keyCode == RIGHT){
    cam.camrotateX(0);
  }
  if (keyCode == UP){
    cam.camrotateY(0);
  }
  if (keyCode == DOWN){
    cam.camrotateY(0);
  }
  if (key == ' '){
    cam.moveZ(0);
  }
  if (keyCode == SHIFT){
    cam.moveZ(0);
  }
}


class ColorItem{
  
  int R, G, B, X, Y, Z, S;
  
  ColorItem(int R, int G, int B, int X, int Y, int Z, int S){
    this.R = R;
    this.G = G;
    this.B = B;
    this.X = X;
    this.Y = Y;
    this.Z = Z;
    this.S = S;
  }
  
  int getR(){
    return R;
  }
  
  int getG(){
    return G;
  }
  
  int getB(){
    return B;
  }
  
  int getX(){
    return X;
  }
  
  int getY(){
    return Y;
  }
  
  int getZ(){
    return Z;
  }
  
  int getS(){
    return S;
  }
}


class Camara{
  
  float rotationAngle;
  float cameraReduction;
  
  float realPosX, lookX, realPosY, lookY, realPosZ, lookZ;
  
  int directionX, directionY, directionZ;
  float xMove, yMove, zMove;
  
  PShape esfera;
  Camara(float rA, float cS){
    rotationAngle = rA;
    cameraReduction = cS;
    
    realPosX = width/2.0;
    lookX = width/2.0;
    realPosY = (height/2.0)-800;
    lookY = height/2.0;
    realPosZ = 1500;
    lookZ = 0; 
    
    directionX = 0;
    directionY = 0;
    directionZ = 0;
  }

  void reset(){
    realPosX = width/2.0;
    lookX = width/2.0;
    realPosY = (height/2.0)-800;
    lookY = height/2.0;
    realPosZ = 1500;
    lookZ = 0; 

    directionX = 0;
    directionY = 0;
  }
 
  void display(){
    if (directionX != 0){
      lookX = ((lookX - realPosX) * cos(radians(directionX*rotationAngle)) - (lookZ - realPosZ) * sin(radians(directionX*rotationAngle))) + realPosX;
      lookZ = ((lookX - realPosX) * sin(radians(directionX*rotationAngle)) + (lookZ - realPosZ) * cos(radians(directionX*rotationAngle))) + realPosZ;
    }
    if (directionY != 0){
      lookY = lookY +(50*directionY);
    }
    if (directionZ != 0){
      xMove = (lookX-realPosX)/cameraReduction;
      yMove = (lookY-realPosY)/cameraReduction;
      zMove = (lookZ-realPosZ)/cameraReduction;
      
      realPosX = realPosX + directionZ*xMove;
      lookX = lookX + directionZ*xMove;
      
      realPosY = realPosY +directionZ*yMove;
      lookY = lookY + directionZ*yMove;
      
      realPosZ = realPosZ + directionZ*zMove;
      lookZ = lookZ + directionZ*zMove;
    }
    camera(realPosX, realPosY,  realPosZ, lookX, lookY, lookZ, 0, 1, 0);
  }
  
  void camrotateX(int direction){
    directionX = direction;
  }
  
  void camrotateY(int direction){
    directionY = direction;
  }
  
  void moveZ(int direction){
    directionZ = direction;
  }
  
  float getPosX(){
    return realPosX;
  }
  
  float getPosY(){
    return realPosY;
  }
  
  float getPosZ(){
    return realPosZ;
  }
  
  float getLookX(){
    return lookX;
  }
  
  float getLookY(){
    return lookY;
  }
  
  float getLookZ(){
    return lookZ;
  }
}
