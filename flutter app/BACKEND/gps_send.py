import pyrebase
import serial
import pynmea2

firebaseConfig={"apiKey": "AIzaSyAIfcHIOKJjDLkR5d0Rdf5bX31Ih6xQEvE",
  "authDomain": "gps-tracker-5d1ae.firebaseapp.com",
  "databaseURL": "https://gps-tracker-5d1ae-default-rtdb.firebaseio.com",
  "projectId": "gps-tracker-5d1ae",
  "storageBucket": "gps-tracker-5d1ae.appspot.com",
  "messagingSenderId": "494155644916",
  "appId": "1:494155644916:web:41b8a0c8f388232c47c3a1"    }

firebase=pyrebase.initialize_app(firebaseConfig)
db=firebase.database()

while True:
        port="/dev/ttyAMA0"
        ser=serial.Serial(port, baudrate=9600, timeout=0.5)
        dataout = pynmea2.NMEAStreamReader()
        newdata=ser.readline()
        n_data = newdata.decode('latin-1')
        if n_data[0:6] == '$GPRMC':
                newmsg=pynmea2.parse(n_data)
                lat=newmsg.latitude
                lng=newmsg.longitude
                gps = "Latitude=" + str(lat) + " and Longitude=" + str(lng)
                print(gps)
                data = {"LAT": lat, "LNG": lng}
                db.update(data)
                print("Data sent")

