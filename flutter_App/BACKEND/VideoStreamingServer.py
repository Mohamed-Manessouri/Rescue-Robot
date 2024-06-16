from flask import Flask, Response
import cv2
from ultralytics import YOLO

app = Flask(__name__)

def generate():
    stream_url = "http://10.1.8.243:8080/?action=stream"  # Replace with your stream URL
    cap = cv2.VideoCapture(stream_url)

    model = YOLO("yolov8n.pt")  # Load your YOLO model

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        results = model.predict(source=frame, show=False)  # Perform object detection on the frame
        detections = results[0].boxes.data.tolist()  # Extract detections as a list

        for detection in detections:
            x1, y1, x2, y2, score, class_id = detection
            label = results[0].names[int(class_id)]  # Get the label name

            # Draw bounding box and label on the frame
            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
            cv2.putText(frame, label, (int(x1), int(y1 - 10)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (36, 255, 12), 2)

        _, jpeg = cv2.imencode('.jpg', frame)
        frame = jpeg.tobytes()

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')

    cap.release()

@app.route('/video_feed')
def video_feed():
    return Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
