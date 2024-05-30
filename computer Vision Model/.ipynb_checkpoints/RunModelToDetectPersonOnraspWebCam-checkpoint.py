import cv2
import requests
from ultralytics import YOLO

# Replace the URL with the IP address and port of your Flask server
server_url = "http://192.168.56.1:5000/receive_frame"  # Replace with actual IP address and port

# Replace the URL with the IP address and port of your Raspberry Pi's video stream
stream_url = "http://192.168.0.105:8080/?action=stream"

# Open the video stream
cap = cv2.VideoCapture(stream_url)

# Load your object detection model
model = YOLO("yolov8n.pt")  # Load the YOLOv8n model

while True:
    # Read a frame from the video stream
    ret, frame = cap.read()

    # Check if the frame was read successfully
    if not ret:
        print("Error reading frame")
        break

    # Run object detection on the frame
    results = model.predict(source=frame, show=False)  # Perform object detection on the frame

    # Get the bounding boxes and labels from the results
    detections = results[0].boxes.data.tolist()  # Extract the detections as a list

    # Display the frame with bounding boxes and labels
    for detection in detections:
        # Get the bounding box coordinates and label
        x1, y1, x2, y2, score, class_id = detection
        label = results[0].names[int(class_id)]  # Get the label name

        # Draw a bounding box and label on the frame
        cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
        cv2.putText(frame, label, (int(x1), int(y1 - 10)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (36, 255, 12), 2)

    # Encode the frame as a JPEG before sending
    _, img_encoded = cv2.imencode('.jpg', frame)
    response = requests.post(server_url, files={'image': img_encoded.tobytes()})

    # Check if the request was successful
    if response.status_code != 200:
        print("Error sending frame to server")
        break

    # Display the processed frame locally (optional)
    cv2.imshow('Video Stream', frame)

    # Wait for the 'q' key to quit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture object and close the window
cap.release()
cv2.destroyAllWindows()
