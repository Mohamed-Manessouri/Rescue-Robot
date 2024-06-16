from flask import Flask, Response, render_template
import cv2
import torch

app = Flask(__name__)

# Load the model
model = torch.hub.load('ultralytics/yolov5', 'custom', path='C:/Users/moman/projects/Rescue-Robot/flutter_App/BACKEND/best.pt')

# Stream video from mjpg streamer
video_stream_url = 'http://10.1.8.243:8080/?action=stream'

def gen():
    cap = cv2.VideoCapture(video_stream_url)

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        # Run inference
        results = model(frame)

        # Render results
        results.render()

        # Convert to JPEG
        ret, buffer = cv2.imencode('.jpg', results.imgs[0])
        frame = buffer.tobytes()

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

    cap.release()

@app.route('/video_feed')
def video_feed():
    return Response(gen(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
