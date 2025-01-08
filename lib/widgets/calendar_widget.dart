import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';

class CalendarWidget extends StatefulWidget {
  final List<Event> events;
  final void Function(DateTime selectedDay) onDaySelected;

  const CalendarWidget({
    required this.events,
    required this.onDaySelected,
    Key? key,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Map<DateTime, List<Event>> _events;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = _groupEventsByDate(widget.events);
  }

  Map<DateTime, List<Event>> _groupEventsByDate(List<Event> events) {
    Map<DateTime, List<Event>> groupedEvents = {};
    for (var event in events) {
      DateTime eventDate = DateTime(event.date.year, event.date.month, event.date.day);
      if (groupedEvents[eventDate] == null) {
        groupedEvents[eventDate] = [];
      }
      groupedEvents[eventDate]?.add(event);
    }
    return groupedEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2025, 12, 31),
          focusedDay: _selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
            widget.onDaySelected(selectedDay);
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          eventLoader: (day) {
            return _events[day] ?? [];
          },
        ),
        const SizedBox(height: 10),
        if (_events[_selectedDay] != null && _events[_selectedDay]!.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: _events[_selectedDay]!.length,
              itemBuilder: (context, index) {
                final event = _events[_selectedDay]![index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text('Location: ${event.location}'),
                );
              },
            ),
          )
        else
          const Center(child: Text('No events for this day')),
      ],
    );
  }
}
