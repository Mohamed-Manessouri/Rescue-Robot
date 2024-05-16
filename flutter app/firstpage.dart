import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


String serverUrl = 'http://169.254.41.148:5000';
String videoStreamUrl = 'http://169.254.41.148:8080/?action=stream';


class FirstPage extends HookWidget {



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



  @override
  Widget build (BuildContext context){
    final isRunning = useState(true);
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],


      // the AppBar that contain the menu , map icon
      appBar: AppBar(
        title:const  Text("RescueApp",
          style: TextStyle(
            color: Colors.white,
          ),),
        centerTitle: true, // Center align the title

        backgroundColor: Colors.deepOrange,
        elevation: 4, //navigate to second page

        iconTheme: const IconThemeData(color: Colors.white),

        actions: [
          IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                Navigator.pushNamed(context, '/secondpage');
              } //On pressed ,
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


          // Spacer to create some space between video and buttons
          const SizedBox(height: 0),



          // Buttons for controlling the car's movement
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Forward button
              ElevatedButton(
                onPressed: () {
                  moveForward();
                },
                child: const Text('Forward'),
              ),
            ],
          ),


          // Spacer between rows
          const SizedBox(height: 20), // Add space of 20 logical pixels between rows



          // Middle row for Stop Right Left
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Right button
              ElevatedButton(
                onPressed: () {
                  moveRight();
                },
                child: const Text('Right'),
              ),

              // Stop button
              ElevatedButton(
                onPressed: () {
                  stopMotors();
                },
                child: const Text('Stop'),
              ),
              // Left button
              ElevatedButton(
                onPressed: () {
                  moveLeft();
                },
                child: const Text('Left'),
              ),
            ],
          ),


          // Spacer between rows
          const SizedBox(height: 20), // Add space of 20 logical pixels between rows




          // Row for backward movement buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Backward button
              ElevatedButton(
                onPressed: () {
                  moveBackward();
                },
                child: const Text('Backward'),
              ),
            ],
          ),
          // Spacer to create some space between video and buttons
          const SizedBox(height: 50),
        ],
      ),




    );
  }  // build
}  // class
