int grid[4][4] = {{'D', 'C', 'B', 'A'},
                  {'#', '9', '6', '3'},
                  {'0', '8', '5', '2'},
                  {'*', '7', '4', '1'}};
                  
                  

int password[4] = {'8', '5', '#', 'A'};
int index = 0;

void button(int col, int row) {
  int pressed = grid[col][row];
  int i;
  char letter = pressed;
  Serial.println(letter);
//  Serial.println(pressed);
  if (pressed == 42) {
    for (i=10; i<14; i++) digitalWrite(i, LOW);
    index = 0;
  }
  
  else if (pressed == password[index]) {
    digitalWrite(index+10, HIGH);
    index++;
  }
  
  if (index == 4) Serial.println("Correct");

}
                  
void setup() {
  int i;
  Serial.begin(9600);
  Serial.println("Setup");
  for (i=2; i<6; i++) pinMode(i, OUTPUT);
  for (i=6; i<10; i++) pinMode(i, INPUT);
  for (i=10; i<14; i++) pinMode(i, OUTPUT);
}


void loop() {
  int i;
  int j;
  for (i=2; i<6; i++) {
    digitalWrite(i, HIGH);
    for (j=6; j<10; j++) {
      if (digitalRead(j) == HIGH) {
        button(i-2, j-6);
        while (digitalRead(j)) ;    // Busy-wait loop for debounce
      }
    }
    digitalWrite(i, LOW);
  }
}
