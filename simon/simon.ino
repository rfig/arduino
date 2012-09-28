#include <Time.h>

const int rled = 2;
const int gled = 3;
const int bled = 4;

const int rbutton = 5;
const int gbutton = 6;
const int bbutton = 7;

int buttonState;

int sequence[50];

boolean incorrect = false;
boolean guess = false;
int stage = 0;



void setup() {
  // sets led pins to send output
  pinMode(rled, OUTPUT);
  pinMode(gled, OUTPUT);
  pinMode(bled, OUTPUT);
  // sets button pins to read inputs
  pinMode(rbutton, INPUT);
  pinMode(gbutton, INPUT);
  pinMode(bbutton, INPUT);
  pinMode(8, OUTPUT);
  digitalWrite(rled, HIGH);
  while (!digitalRead(rbutton));
  digitalWrite(rled, LOW);
  delay(250);
  randomSeed(micros());
}

void Blink(int led) {
  digitalWrite(led, HIGH);
  tone(8, 110 * pow(2, led), 500);
  delay(500);
  digitalWrite(led, LOW);
}

void play() {
  for (int i=0; i<=stage; i++) {
    Blink(sequence[i]);
    delay(250);
  }
}

void loop() {
  sequence[stage] = random(2,5);
  // plays sequence the player is supposed to repeat 
  if (!incorrect) {
    play();
  }
  
  // gets user input 
  for (int i=0; i<=stage; i++) {
    while (guess == false and incorrect == false) {
      // checks button state
      for (int j=0;j<3;j++) {
        buttonState = digitalRead(rbutton + j);
        if (buttonState == HIGH) 
          if (sequence[i] == rled + j) {
            Blink(rled + j);
            guess = true;
          }
          else {
            tone(8, 55, 1500);
            delay(1750);
            incorrect = true;
            play();
          }
      }
    }
    guess = false;
  }
  delay(600);
  stage++;
}



