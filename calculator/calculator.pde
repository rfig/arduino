
int number = 0;
int answer = 0;

int index = 0;
int inputs[50];
int operations[50];

char ops[4] = {'+', '-', '*', '/'};

int grid[4][4] = {{'D', 'C', 'B', 'A'},
                  {'E', 9, 6, 3},
                  {0, 8, 5, 2},
                  {'F', 7, 4, 1}};


void reset() {
  number = 0;
  index = 0;
  
  for (int n=0; n<50; n++) {
    inputs[n] = 0;
    operations[n] = 0;
  }
  Serial.println(' ');
}


void result() {
  answer = inputs[0];
  for (int n=0; n<50; n++) {
    if (operations[n] == 'A') answer += inputs[n+1];
    else if (operations[n] == 'B') answer -= inputs[n+1];
  }
  Serial.println(' ');
  Serial.println(answer);
  reset();
}

void button(int col, int row) {
  int pressed;
  pressed = grid[col][row];
  
  switch (pressed) {
    case 'A':
    case 'B':
    case 'C':
    case 'D':
    case 'E':
      if (operations[index-1] == 'C') {
        inputs[index-1] *= number;
        operations[index-1] = pressed;
      }
      else if (operations[index-1] == 'D') {
        inputs[index-1] /= number;
        operations[index-1] = pressed;
      }

      else {
        operations[index] = pressed;
        inputs[index] = number;
        index++;
      }

      if (pressed == 'E') result();
      else {
        number = 0;
        Serial.print(ops[pressed-65]);
      }
      break;
      
    case 'F':
      reset();
      break;

    default:
      number *= 10;
      number += pressed;
      Serial.print(pressed);
  }
}


void setup() {
  int i;
  Serial.begin(9600);
  Serial.println("Setup");
  for (i=2; i<6; i++) pinMode(i, OUTPUT);
  for (i=6; i<10; i++) pinMode(i, INPUT);
  //pinMode(13, OUTPUT);
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

/*
void button(int col, int row) {
  pressed = grid[col][row];
  if (pressed >= 'A') {
    if (operations[index-1] == 'C') {
      input[index-1] *= number;
      operations[index-1] = pressed;
    }
    else if (operations[index-1] == 'D') {
      input[index-1] /= number;
      operations[index-1] = pressed;
    }
    
    else {
      operations[index] = pressed;
      input[index] = number;
      index++;
    }
    
    if (pressed == 'E') result();
    if (pressed == 'F') reset();
    number = 0;
  }
  
  else {
    number *= 10;
    number += pressed;
  }
}*/
