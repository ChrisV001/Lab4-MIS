import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../services/directions_service.dart';
import '../models/event.dart';
import '../services/location_service.dart';

class MapWidget extends StatefulWidget {
  final Event event;

  const MapWidget({required this.event, Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  late LatLng _eventLocation;
  late LatLng _currentLocation;
  late Set<Marker> _markers;
  late Set<Polyline> _polylines;

  @override
  void initState() {
    super.initState();
    _markers = {};
    _polylines = {};
    _eventLocation = LatLng(widget.event.latitude, widget.event.longitude);
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationData? locationData = await LocationService.getCurrentLocation();
    if (locationData != null) {
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _markers.add(Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation,
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
        _getDirections(_currentLocation, _eventLocation);
      });
    }
  }

  Future<void> _getDirections(LatLng origin, LatLng destination) async {
    Directions? directions = await DirectionsService.getDirections(
      origin: origin,
      destination: destination,
    );
    if (directions != null) {
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: directions.polylinePoints,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Location')),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _eventLocation,
          zoom: 14.0,
        ),
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
