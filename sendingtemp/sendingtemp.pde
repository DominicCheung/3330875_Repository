//So this is the script that I used to send temperature data to the camera and replacing the altitude value
//This is based on a script provided by Josh Harle, so all credits to him. I only changed the temperature sensor and sending the temperature value to GPS.

int temperaturePin = 0;

void setup() {
  pinMode(13, OUTPUT);
  Serial.begin(4800);
}

void loop()
{

  float temperature = getVoltage(temperaturePin);
  temperature = (temperature - .5) * 100;
  //Serial.println(temperature);
  
  sendValue(temperature*100);
  //sendValue(100);
  delay(500);

}

void sendValue(int value) {
  digitalWrite(13, HIGH);  
  Serial.println(GPRMC());
  delay(100);
  Serial.println(GPGGA(value));
  delay(100);
  digitalWrite(13, LOW);  
}

float getVoltage(int pin){
  return (analogRead(pin) * .004882814);
}

String GPRMC() {
  String sentence  = "GPRMC,184332.07,A,1929.459,S,02410.381,E,74.00,16.78,210410,0.0,E,A";
  return "$" + sentence + "*" + calculateChecksum(sentence);
}

String GPGGA(int Altitude) {
  String sentence  = "GPGGA,184333.07,1929.439,S,02410.387,E,1,04,2.8,"+String(Altitude)+",M,0,M,,0000";
  return "$" + sentence + "*" + calculateChecksum(sentence);
}


String calculateChecksum(String instring) {

  int thisChecksum = 0;
  for (int i = 0; i < instring.length(); i++) {
    thisChecksum ^= (byte)instring[i];
  }

  return String(thisChecksum, HEX);
}

