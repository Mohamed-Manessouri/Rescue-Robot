#include <AFMotor.h>
#include <Servo.h>

AF_DCMotor motor1(1); // Motor connected to M1
AF_DCMotor motor2(2); // Motor connected to M2
Servo myServo;

void setup() {
  Serial.begin(9600);// Initialize serial communication at 9600 baud rate
  myServo.attach(10);
}

void loop() {
  if (Serial.available() > 0) { // Check if data is available to read
    char command = Serial.read(); // Read the incoming byte
    
    // Process the received command
    switch (command) {
      case 'F':
        moveForward();
        break;
      case 'B':
        moveBackward();
        break;
      case 'L':
        turnLeft();
        break;
      case 'R':
        turnRight();
        break;
      case 'S':
        stopMotors();
        break;
      case 'A':
        moveServoRight();
        break;
      case 'C': // Change this to a unique character, like 'C'
        moveServoLeft();
        break;
      default:
        // Invalid command, do nothing or handle error
        break;
    }
  }
}

// Define functions to control motor movements
void moveForward() {
  motor1.setSpeed(255);
  motor2.setSpeed(255);
  motor1.run(FORWARD);
  motor2.run(FORWARD);
}

void moveBackward() {
  motor1.setSpeed(255);
  motor2.setSpeed(255);
  motor1.run(BACKWARD);
  motor2.run(BACKWARD);
}

void turnLeft() {
  motor1.setSpeed(200);
  motor2.setSpeed(200);
  motor1.run(BACKWARD);
  motor2.run(FORWARD);
}

void turnRight() {
  motor1.setSpeed(200);
  motor2.setSpeed(200);
  motor1.run(FORWARD);
  motor2.run(BACKWARD);
}

void stopMotors() {
  motor1.run(RELEASE);
  motor2.run(RELEASE);
}

void moveServoRight() {
  myServo.write(90);
}

void moveServoLeft() {
  myServo.write(0);
}