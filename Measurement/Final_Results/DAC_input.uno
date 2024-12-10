// define output pins
const int dacPins[8] = {2, 3, 4, 5, 6, 7, 8, 9};

// set the digital bits from MSB to LSB
byte data = 0b11110000;  

void setup() {
  for (int i = 0; i < 8; i++) {
    pinMode(dacPins[i], OUTPUT);
  }

  updateDACOutput();
}

void loop() {
}

void updateDACOutput() {
  // D2 is MSB
  for (int i = 0; i < 8; i++) {
    digitalWrite(dacPins[i], (data >> (7 - i)) & 0x01); 
  }
}
