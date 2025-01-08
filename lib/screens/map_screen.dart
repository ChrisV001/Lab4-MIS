import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/event.dart';

class MapScreen extends StatefulWidget {
  final Event event;

  const MapScreen({required this.event, Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.event.latitude, widget.event.longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('event_location'),
            position: LatLng(widget.event.latitude, widget.event.longitude),
            infoWindow: InfoWindow(
              title: widget.event.title,
              snippet: widget.event.location,
            ),
          ),
        },
        polylines: _buildRoutePolyline(),
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }

  Set<Polyline> _buildRoutePolyline() {
    // Replace with actual start location if available
    LatLng startLocation = LatLng(37.7749, -122.4194); // Example start point

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [
          startLocation,
          LatLng(widget.event.latitude, widget.event.longitude),
        ],
        color: Colors.blue,
        width: 5,
      ),
    };
  }
}
