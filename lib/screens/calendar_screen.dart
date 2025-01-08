import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/event.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(sampleEvents),
        initialSelectedDate: DateTime.now(),
        onTap: (CalendarTapDetails details) {
          if (details.appointments != null && details.appointments!.isNotEmpty) {
            final Event event = details.appointments!.first;
            _showEventDetailsDialog(context, event);
          }
        },
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showAgenda: true,
        ),
      ),
    );
  }

  void _showEventDetailsDialog(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${event.date.toLocal()}'),
              const SizedBox(height: 8),
              Text('Location: ${event.location}'),
              const SizedBox(height: 8),
              if (event.description.isNotEmpty) Text('Description: ${event.description}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// Data source for the calendar
class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> events) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].date;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].date.add(const Duration(hours: 2));
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  String getLocation(int index) {
    return appointments![index].location;
  }

  @override
  Color getColor(int index) {
    return Colors.blue;
  }
}
