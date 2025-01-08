import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Event> _scheduledEvents = [];

  @override
  void initState() {
    super.initState();
    _loadScheduledNotifications();
  }

  Future<void> _loadScheduledNotifications() async {
    final events = await NotificationService.getScheduledNotifications();
    setState(() {
      _scheduledEvents = events;
    });
  }

  void _cancelNotification(String id) async {
    await NotificationService.cancelNotification(id);
    _loadScheduledNotifications(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scheduledEvents.isEmpty
          ? const Center(
              child: Text(
                'No notifications scheduled.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _scheduledEvents.length,
              itemBuilder: (context, index) {
                final event = _scheduledEvents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Text(
                        'Date: ${event.date.toLocal()}\nLocation: ${event.location}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => _cancelNotification(event.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
