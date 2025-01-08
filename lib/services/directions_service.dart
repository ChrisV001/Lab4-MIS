import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  static Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    return Directions(
      polylinePoints: [
        origin,
        LatLng((origin.latitude + destination.latitude) / 2, (origin.longitude + destination.longitude) / 2),
        destination,
      ],
    );
  }
}

class Directions {
  final List<LatLng> polylinePoints;

  Directions({required this.polylinePoints});
}
