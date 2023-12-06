import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const GeolocatorWidget());
}

class GeolocatorWidget extends StatelessWidget {
  const GeolocatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GeolocatorScreen(),

    );
  }
}

class GeolocatorScreen extends StatefulWidget {
  const GeolocatorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GeolocatorScreenState createState() => _GeolocatorScreenState();
}

class _GeolocatorScreenState extends State<GeolocatorScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocalizador Alexa'),
        titleTextStyle: const TextStyle(fontSize: 25),
        backgroundColor: const Color.fromRGBO(219, 95, 209, 1)
      ),
          body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_currentPosition != null)
                        Text(
                          'Posición:\n${_currentPosition.toString()}',
                          style: const TextStyle(fontSize: 20, backgroundColor: Color.fromRGBO(214, 141, 208, 1,)),
                          textAlign: TextAlign.center, 
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _getCurrentPosition();
        },
        tooltip: 'Geolocalización',
        child: const Icon(Icons.location_on_outlined,color:Color.fromRGBO(219, 95, 209, 1),),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (hasPermission) {
      final position = await _geolocatorPlatform.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    }
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    return true;
  }
}