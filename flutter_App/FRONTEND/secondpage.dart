import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.ref();

  double? _lat;
  double? _lng;

  @override
  void initState() {
    super.initState();
    _listenToLocationUpdates();
  }

  void _listenToLocationUpdates() {
    _databaseReference.child('location').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final lat = data['LAT'] as double?;
      final lng = data['LNG'] as double?;

      setState(() {
        _lat = lat;
        _lng = lng;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Location Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          if (_lat != null && _lng != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Latitude: $_lat, Longitude: $_lng',
                style: TextStyle(fontSize: 20),
              ),
            ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_lat ?? 0.0, _lng ?? 0.0),
                zoom: 15,
              ),
              onMapCreated: (controller) {
                setState(() {
                });
              },
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(_lat ?? 0.0, _lng ?? 0.0),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
