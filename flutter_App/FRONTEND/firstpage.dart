import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RescueApp',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends HookWidget {
  final String serverUrl = 'http://192.168.0.105:5000';
  final String videoStreamUrl = 'http://10.1.6.71:5000/video_feed';  // Ensure this matches your Flask server URL

  Future<void> moveForward() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/forward'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> moveBackward() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/backward'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> stopMotors() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/stop'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> moveRight() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/right'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> moveLeft() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/left'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> ServoRight() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/ServoRight'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> ServoLeft() async {
    try {
      final response = await http.post(Uri.parse('$serverUrl/ServoLeft'));
      print(response.body);
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        title: const Text(
          "RescueApp",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.pushNamed(context, '/secondpage');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Streaming Widget
          Expanded(
            child: Mjpeg(
              isLive: isRunning.value,
              error: (context, error, stack) {
                print(error);
                print(stack);
                return Text(error.toString(), style: TextStyle(color: Colors.red));
              },
              stream: videoStreamUrl,
            ),
          ),

          const SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  ServoRight();
                },
                child: const Text('Sright'),
              ),
              ElevatedButton(
                onPressed: () {
                  moveForward();
                },
                child: const Text('Forward'),
              ),
              ElevatedButton(
                onPressed: () {
                  ServoLeft();
                },
                child: const Text('Sleft'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  moveRight();
                },
                child: const Text('Right'),
              ),
              ElevatedButton(
                onPressed: () {
                  stopMotors();
                },
                child: const Text('Stop'),
              ),
              ElevatedButton(
                onPressed: () {
                  moveLeft();
                },
                child: const Text('Left'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  moveBackward();
                },
                child: const Text('Backward'),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
