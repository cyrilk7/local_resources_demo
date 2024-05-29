import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng? currentPosition;
  final MapController mapController = MapController();
  bool mapReady = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }

      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    if (mapReady) {
      mapController.move(
        LatLng(position.latitude, position.longitude),
        15.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentPosition == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : FlutterMap(
            mapController: mapController,
            options: MapOptions(
                initialCenter: currentPosition ?? const LatLng(0, 0),
                initialZoom: 15,
                onMapReady: () {
                  setState(() {
                    mapReady = true;
                  });
                  if (currentPosition != null) {
                    mapController.move(currentPosition!, 15.0);
                  }
                }),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: currentPosition!,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 40.0,
                  ),
                ),
              ])
            ],
          );
  }
}