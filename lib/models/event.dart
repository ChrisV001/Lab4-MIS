import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event {
  final String id; 
  final String title; 
  final DateTime date; 
  final String location; 
  final LatLng coordinates;
  final String description;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.coordinates,
    this.description = '',
  });
}


List<Event> sampleEvents = [
  Event(
    id: '1',
    title: 'Math Exam',
    date: DateTime.now().add(Duration(days: 1, hours: 9)),
    location: 'Room 204, Main Building',
    coordinates: LatLng(37.7749, -122.4194),
    description: 'Bring all required tools (calculator, pen, etc.)',
  ),
  Event(
    id: '2',
    title: 'Physics Exam',
    date: DateTime.now().add(Duration(days: 3, hours: 14)),
    location: 'Auditorium B',
    coordinates: LatLng(37.7786, -122.4313),
    description: 'Focus on chapters 4-7',
  ),
];
