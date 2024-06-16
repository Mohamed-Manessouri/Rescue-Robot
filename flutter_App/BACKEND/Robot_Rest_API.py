from flask import Flask
app = Flask(__name__)



import serial

# Define the serial port and baud rate
SERIAL_PORT = '/dev/ttyACM0'  # This may vary depending on your Raspberry Pi configuration
BAUD_RATE = 9600

# Initialize serial connection
ser = serial.Serial(SERIAL_PORT, BAUD_RATE)

# Function to send forward command to Arduino
def send_forward_command():
    try:
        ser.write(b'F')  # Send 'F' to Arduino (assuming 'F' is the command for forward movement)
        print('Forward command sent to Arduino')
        return 'Forward command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'

@app.route('/forward', methods=['POST'])
def forward():
    return send_forward_command()


# Function to send forward command to Arduino
def send_backward_command():
    try:
        ser.write(b'B')  # Send 'F' to Arduino (assuming 'F' is the command for forward movement)
        print('Backward command sent to Arduino')
        return 'Backward command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'

@app.route('/backward', methods=['POST'])
def backward():
    return send_backward_command()


# Function to send forward command to Arduino
def send_stop_command():
    try:
        ser.write(b'S')  # Send 'F' to Arduino (assuming 'F' is the command for forward movement)
        print('Stop command sent to Arduino')
        return 'Stop command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'

@app.route('/stop', methods=['POST'])
def stop():
    return send_stop_command()

# Function to send forward command to Arduino
def send_left_command():
    try:
        ser.write(b'L')  # Send 'F' to Arduino (assuming 'F' is the command for forward movement)
        print('Left command sent to Arduino')
        return 'Left command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'

@app.route('/left', methods=['POST'])
def left():
    return send_left_command()


# Function to send forward command to Arduino
def send_right_command():
    try:
        ser.write(b'R')  # Send 'F' to Arduino (assuming 'F' is the command for forward movement)
        print('Right command sent to Arduino')
        return 'Right command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'

@app.route('/right', methods=['POST'])
def right():
    return send_right_command()


# Function to send RightServo command to Arduino 
def send_right_servo():
    try:
        ser.write(b'A')
        print('RightServo command sent to Arduino')
        return 'RightServo command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'
        
@app.route('/ServoRight', methods=['POST'])
def SRight():
    return send_right_servo():


# Function to send LeftServo command to Arduino 
def send_left_servo():
    try:
        ser.write(b'C')
        print('LeftServo command sent to Arduino')
        return 'LeftServo command sent to Arduino'
    except Exception as e:
        print(f'Error sending command to Arduino: {e}')
        return f'Error sending command to Arduino: {e}'
        
@app.route('/ServoLeft', methods=['POST'])
def SRight():
    return send_left_servo():
        
        
        
        



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug = True)
