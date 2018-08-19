int sensorPin = A0;
int ledPin = 13;
int threshold = 300;
void setup() {
  // put your setup code here, to run once:
  pinMode(sensorPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int value = analogRead(sensorPin);
  if(value > threshold)
  {
    Serial.println(value,DEC);
    delay(150);
  }
}
