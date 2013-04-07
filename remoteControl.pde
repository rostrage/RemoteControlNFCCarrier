/*
* Demo Line follower code for the IEEE Rutgers Line Following robot
* Some quick clean up done 20110403
*
*/

#define motor1Dir 7
#define motor2Dir 8
#define motor1PWM 9
#define motor2PWM 10
#define motor1Enable 11
#define motor2Enable 12
#define buttonA 5
#define buttonB 4
#define buttonC 3
#define buttonD 2


void setMotorVel(int dirPin, int pwmPin, int velocity){
  if (velocity >= 255) velocity = 255;
  if (velocity <= -255) velocity = -255;

  if (velocity == 0)
  {
    digitalWrite(dirPin, HIGH);
    digitalWrite(pwmPin, HIGH);
  }
  else if(velocity <0){ // Reverse
    digitalWrite(dirPin, HIGH);
    analogWrite(pwmPin, 255+velocity);
  }
  else if(velocity >0){ // Forward
    digitalWrite(dirPin,LOW);
    analogWrite(pwmPin, velocity);
  }
}


void setLeftMotorSpeed(int velocity)
{
  setMotorVel(motor1Dir, motor1PWM, -velocity);

}

void setRightMotorSpeed(int velocity){
  setMotorVel(motor2Dir, motor2PWM, -velocity);
}

void initMotorDriver()
{
  pinMode(motor1Dir, OUTPUT);
  pinMode(motor2Dir, OUTPUT);

  pinMode(motor1Enable, OUTPUT);
  pinMode(motor2Enable, OUTPUT);
  digitalWrite(motor1Enable,HIGH);
  digitalWrite(motor2Enable,HIGH);
  setLeftMotorSpeed(0); // make sure the motors are stopped
  setRightMotorSpeed(0);
}




void goForward()
{
  setLeftMotorSpeed(255);
  setRightMotorSpeed(255);
}

void goRight()
{
  setLeftMotorSpeed(255);
  setRightMotorSpeed(-255);
}

void goLeft()
{
  setLeftMotorSpeed(-255);
  setRightMotorSpeed(255);
}


void setup(){
  Serial.begin(115200); //Set the buad rate for the serial com.

  // prints title with ending line break
  Serial.println("Line Sensor board Sensor test");
  pinMode(buttonA, INPUT);
  pinMode(buttonB, INPUT);
  pinMode(buttonC, INPUT);
  pinMode(buttonD, INPUT);
  initMotorDriver();
  
  
}


void loop(){
  if(digitalRead(buttonA)==1)
  {
    goLeft();
  }
  else if(digitalRead(buttonB)==1)
  {
    goRight();
  }
  else if(digitalRead(buttonC)==1)
  {
    goForward();
  }
  else if(digitalRead(buttonD)==1)
  {
    setLeftMotorSpeed(0);
    setRightMotorSpeed(0);
  }
}
