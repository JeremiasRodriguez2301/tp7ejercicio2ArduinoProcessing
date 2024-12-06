#define p1 8                
#define p2 9  
#define led1 7             
#define led2 6           
              
int brilloMax = 250, brilloLed1 = 0, brilloLed2 = 0, incrementoBrillo = 50, brilloActual = 0;  
int ledActual;  
unsigned long ultimoTiempoPresion = 0;  // Variable para controlar el tiempo entre presiones de botones

void setup()
{
  Serial.begin(9600);  
  
  pinMode(p1, INPUT_PULLUP);  
  pinMode(p2, INPUT_PULLUP);  
  pinMode(led1, OUTPUT);  
  pinMode(led2, OUTPUT); 
}

void loop()
{
  // Si el pulsador 1 es presionado y han pasado más de 250 ms desde la última presión
  if (digitalRead(p1) == false && millis() - ultimoTiempoPresion > 250)
  {
    ledActual = led1;  
    brilloActual = brilloLed1;  

    if(brilloLed1 == 0)  
    {
      aumentarBrillo();  
      brilloLed1 = brilloMax; 
      Serial.println("1");  
    }

    else
    {
      disminuirBrillo();  
      brilloLed1 = 0;  
      Serial.println("-1");  
    }

  }

  // Si el pulsador 2 es presionado y han pasado más de 250 ms desde la última presión
  if (digitalRead(p2) == false && millis() - ultimoTiempoPresion > 250)
  {
    ledActual = led2;  
    brilloActual = brilloLed2;  

    if (brilloLed2 == 0)  
    {
      aumentarBrillo();  
      brilloLed2 = brilloMax;  
      Serial.println("2");  
    }
    
    else
    {
      disminuirBrillo();  
      brilloLed2 = 0;  
      Serial.println("-2");  
    }

  }

  // Leer el comando recibido por el puerto serial
  int comando = Serial.read();
  
  if (comando == 1)  
  {
    ledActual = led1; 
    brilloActual = brilloLed1;  

    if (brilloLed1 == 0)  
    {
      aumentarBrillo();  
      brilloLed1 = brilloMax; 
    }

    else
    {
      disminuirBrillo();  
      brilloLed1 = 0;  
    }

  }

  if (comando == 2)  
  {
    ledActual = led2;  
    brilloActual = brilloLed2;  

    if (brilloLed2 == 0)  
    {
      aumentarBrillo();
      brilloLed2 = brilloMax;  
    }

    else
    {
      disminuirBrillo();  
      brilloLed2 = 0; 
    }
    
  }
}


void aumentarBrillo()
{
  while(brilloActual < brilloMax)  
  {
    brilloActual += incrementoBrillo;  
    analogWrite(ledActual, brilloActual);  
    delay(50);  
  }
}


void disminuirBrillo()
{
  while(brilloActual > 0)  
  {
    brilloActual -= incrementoBrillo;  
    analogWrite(ledActual, brilloActual);  
    delay(50);  
  }
}
