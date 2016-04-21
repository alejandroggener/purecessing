
import oscP5.*; // -->se importan las librerías oscP5 y netP5 
import netP5.*; 

OscP5 oscP5; //--> definición del objeto

int puerto; //--> Se define un puerto de entrada para la comunicación osc

float x; //--> varialbe para la posicion x
float y; //--> varialbe para la posicion y

float posX, posY, diametro, alfa; // varialbes para el círculo

void setup() {
  size (400, 400);
  background (255);

  diametro = 50;
  alfa = 255;

  puerto = 11111; // elegimos el puerto, que debe ser el mismo del servidor
  oscP5 = new OscP5(this, puerto); // Entrada: mensajes de entrada por el puerto especificado
}

void draw() {

  background(0);
  //noStroke();
  //fill(255);
colorMode(RGB, 400);
for (int i = 0; i < width; i++) {
  for (int j = 0; j < height; j++) {
    stroke(posX+i, posY+j, 0);
    point(i, j);
  }
}
  fill(255);
//  quad(0,0,400,0,400,400,0,400);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/x")==true) { // si la dirección es "x"
    if (theOscMessage.checkTypetag("f")) {          // si el dato que trae el mensaje es un float
      x = theOscMessage.get(0).floatValue();        // extraemos el primer dato (0) y se lo asignamos a x 
      println("pd--> pos x: "+ x);
      posX = int (map (x, 0, 1.0, 0, width));       // con el x definimos la posición X del círculo
      return;
    }
  }
  
  if (theOscMessage.checkAddrPattern("/y")==true) { // si la dirección es "y"
    if (theOscMessage.checkTypetag("f")) {              // si el dato que trae el mensaje es un float
      y = theOscMessage.get(0).floatValue();      // extraemos el primer dato (0) y se lo asignamos a y 
      println("pd--> pos y: "+ y);
      posY = int (map (y, 0, 1.0, height, 0));    // con el y definimos la posición Y del círculo
      return;
    }
  }
}