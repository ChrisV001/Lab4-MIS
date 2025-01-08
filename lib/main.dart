import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/map_screen.dart';
import 'screens/notification_screen.dart';
import 'models/event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/map': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Event;
          return MapScreen(event: args);
        },
        '/notifications': (context) => NotificationScreen(),
      },
    );
  }
}
