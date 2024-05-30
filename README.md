# Rescue-Robot
Rescue Robot is a robot designed for detecting human survivors in various scenarios such as war zones, earthquake sites, or missing person cases.

 # This robot is equipped with a Raspberry Pi 3, a camera, Arduino Uno , L293d  and other essential hardware components.


The project consists of four main parts:


# A mobile app:
 This app controls the robot’s movements (sending http requests to flask rest Api in raspberry which send it to Arduino for the control) and displays real-time video streaming with human detection capabilities, beside that, it provides real time robot's location from the gps tracker in raspberry pi.


# A computer vision model:
 This model is responsible for detecting humans within the video feed.I m currently using a pretrained model YoloV8 but I m willing to build the model from scratch.


# Video transmission: 
 The webcam captures real-time video, which is then transmitted to the computer vision model in my laptop. Once processed, the annotated video, highlighting human presence, is sent to the mobile app for visualization, that is done using a server who host the video + detections and turn it into a mjpg-streamer format so flutter can get it.

# Gps tracker:
 For this, I used Neo 6m Module Linked to the raspberry pi 3. The python script "gps_send.py" generates location and send it to the real time database in firebase ( A backend as a service platform) where I m creating my project. The flutter app fetch for this data and update the location of the robot.



For now, I m facing some challenges in assuring the video transmission in real time from raspberry pi to the laptop to the mobile app, and I still did not start the gps part yet neither the model.

