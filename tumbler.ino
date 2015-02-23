int pot = A0;
   
int pot_read;
int new_pot_read;

void setup() {
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
  Serial.begin(9600);
}

void loop() {
  pot_read = analogRead(pot);
  new_pot_read = map(pot_read, 0, 1023, 0,360);
  
  Serial.write(new_pot_read);
  delay(100);

}
