import processing.serial.*;
Serial puertoSerial;  

boolean estadoLed1 = false;  
boolean estadoLed2 = false;  
long ultimoTiempo = 0;  // Variable para almacenar el tiempo del ultimo evento
int contadorEntradas;  // Variable para almacenar el número de la entrada seleccionada

void setup()
{
  size(520, 280);  
  puertoSerial = new Serial(this, "COM3", 9600);  
}

void draw()
{
  background(255); 
  
  fill(255); 
  beginShape(); 
    vertex(45, 50);
    vertex(150, 50);
    vertex(150, 93);
    vertex(45, 93);
  endShape(CLOSE);  

  beginShape(); 
    vertex(45, 170);
    vertex(150, 170);
    vertex(150, 213);
    vertex(45, 213);
  endShape(CLOSE);  
  
  // Detecta si el mouse ha sido presionado sobre el área del primer botón 
  boolean boton1 = millis() - ultimoTiempo > 250 && mousePressed && mouseX > 250 && mouseX < 300 && mouseY > 50 && mouseY < 93;
  
  if (boton1) 
  {
    fill(150);  
    noStroke();  
    estadoLed1 = !estadoLed1;  
    ultimoTiempo = millis();  // Actualiza el tiempo del último evento
    contadorEntradas = 1;  // Indica que se ha seleccionado el primer botón
    puertoSerial.write(contadorEntradas); 
  }
  else
  {
    fill(220);  
    stroke(0); 
  }
  
  // Dibujar el primer botón
  beginShape();
    vertex(250, 50);
    vertex(300, 50);
    vertex(300, 93);
    vertex(250, 93);
  endShape(CLOSE);
  

  boolean boton2 = millis() - ultimoTiempo > 250 && mousePressed && mouseX > 350 && mouseX < 400 && mouseY > 50 && mouseY < 93;
  
  if (boton2)  
  {
    fill(150);  
    noStroke();  
    estadoLed2 = !estadoLed2;  
    ultimoTiempo = millis();  
    contadorEntradas = 2;  // Indica que se ha seleccionado el segundo botón
    puertoSerial.write(contadorEntradas);  
  }
  else
  {
    fill(220);  
    stroke(0);  
  }
  
  // Dibujar el segundo botón
  beginShape();
    vertex(350, 50);
    vertex(400, 50);
    vertex(400, 93);
    vertex(350, 93);
  endShape(CLOSE);
  
  stroke(0);  
  
  // Dibujar el LED1 (salida)
  if(estadoLed1 == true)
  {
    fill(255, 179, 179);  // Si el LED1 está encendido, lo pinta de rojo claro
  }
  else
  {
    fill(255);  // Si el LED1 está apagado, lo pinta de blanco
  }
  
  beginShape();
    ellipse(275, 191, 50, 50);  // Dibuja un círculo (LED1)
  endShape(CLOSE);
  
  // Dibuja el LED2 (salida)
  if(estadoLed2 == true)
  {
    fill(152, 255, 152);  // Si el LED2 está encendido, lo pinta de verde claro
  }
  else
  {
    fill(255);  // Si el LED2 está apagado, lo pinta de blanco
  }
  
  beginShape();
   ellipse(375, 191, 50, 50);  // Dibuja un círculo (LED2)
  endShape(CLOSE);
  
  fill(0);  
  textSize(25);  
  text("Entradas", 50, 80);  
  text("Salidas", 60, 200);  
  textSize(23);  
  text("E1", 265, 79);  
  text("E2", 365, 79);  
  text("S1", 264, 199);  
  text("S2", 364, 199);  
}


void serialEvent(Serial puertoSerial)
{
  int aux;
  String clave = puertoSerial.readStringUntil('\n');  // Lee una línea de datos desde el puerto serial
  if (clave != null)
  {
    aux = int(trim(clave));  // Convierte la cadena de texto a un valor entero
    if(aux == 1)  
      estadoLed1 = true;
      
    if (aux == -1)  
      estadoLed1 = false;
      
    if(aux == 2)  
      estadoLed2 = true;
      
    if (aux == -2)  
      estadoLed2 = false;
  }
}
