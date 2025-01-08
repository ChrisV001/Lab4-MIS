import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/event.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _notifications.initialize(settings);
  }

  static Future<void> scheduleNotification(Event event) async {
    const androidDetails = AndroidNotificationDetails(
      'main_channel',
      'Main Channel',
      importance: Importance.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      int.parse(event.id),
      event.title,
      'At ${event.location}',
      event.date,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  static Future<List<Event>> getScheduledNotifications() async {
    return sampleEvents;
  }

  static Future<void> cancelNotification(String id) async {
    await _notifications.cancel(int.parse(id));
  }
}
