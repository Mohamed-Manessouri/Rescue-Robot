import 'package:flutter/material.dart';



class SecondPage extends StatelessWidget{
  const SecondPage({super.key});

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map",
          style: TextStyle(
            color: Colors.white,
          ),),
        centerTitle: true, // Center align the title

        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}



