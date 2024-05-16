# Rescue-Robot
Rescue Robot is a robot designed for detecting human survivors in various scenarios such as war zones, earthquake sites, or missing person cases.

 # This robot is equipped with a Raspberry Pi 3, a camera, Arduino Uno , L293d  and other essential hardware components.


The project consists of three main parts:


# A mobile app:
 This app controls the robot’s movements (sending http requests to flask rest Api in raspberry which send it to Arduino for the control) and displays real-time video streaming with human detection capabilities.


# A computer vision model:
this model is responsible for detecting humans within the video feed.


# Video transmission: 
The webcam captures real-time video, which is then transmitted to the computer vision model in my laptop. Once processed, the annotated video, highlighting human presence, is sent to the mobile app for visualization.

