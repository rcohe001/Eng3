/*
  Testing setup for multiple ultrasonic sensors
 */
 
int trigPins[] = {11,9};
int echoPins[] = {12,10};
long duration;
int distance[2];
  int delaybetween = 0;
int delayafter = 50;
int sensorNum = 2;

// the setup routine runs once when you press reset:
void setup() {             
  Serial.begin(9600);


for (int i = 0; i < sensorNum; i++) {
     pinMode(trigPins[i], OUTPUT);
     pinMode(echoPins[i], INPUT);
      }
}

// the loop routine runs over and over again forever:
void loop() {
    int delaybetween = 50;

  for(int i=0; i< sensorNum; i++){
          digitalWrite(trigPins[i], LOW);  // Added this line
          delayMicroseconds(2); // Added this line
          digitalWrite(trigPins[i], HIGH);
      
          delayMicroseconds(10); // Added this line
          digitalWrite(trigPins[i], LOW);
          duration = pulseIn(echoPins[i], HIGH);
          distance[i] = (duration/2) / 29.1;

          Serial.print(distance[i]);
          
          if (i<sensorNum-1)  {
                      Serial.print(",");
          }

    
          delay(delaybetween);
  }
  Serial.println(" ");
}
