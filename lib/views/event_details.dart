import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

class EventDetails extends StatefulWidget {
  final CalendarEvent activeEvent;
  final CalendarPlugin calendarPlugin;

  const EventDetails({super.key, 
    required this.activeEvent,
    required this.calendarPlugin,
  });

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activeEvent.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Description: ${widget.activeEvent.description}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Text('Start Date: ${widget.activeEvent.startDate}'),
                  const SizedBox(height: 20),
                  Text('End Date: ${widget.activeEvent.endDate}'),
                  const SizedBox(height: 20),
                  Text('Location: ${widget.activeEvent.location}'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            setState(() {
              _addAttendee(widget.activeEvent.eventId!);
            });
          }),
    );
  }

  buildAttendeeList() {
    return FutureBuilder<List<Attendee>?>(
      future: _getAttendees(widget.activeEvent.eventId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('No Attendee found'));
        }
        List<Attendee> attendees = snapshot.data!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text('Attendee: ${attendees.length}'),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                Attendee attendee = attendees.elementAt(index);
                return populateListContent(attendee);
              },
            ),
          ],
        );
      },
    );
  }

  Widget populateListContent(Attendee attendee) {
    return Dismissible(
      key: Key(attendee.emailAddress),
      confirmDismiss: (direction) async {
        setState(() {
          widget.calendarPlugin.deleteAttendee(
            eventId: widget.activeEvent.eventId!,
            attendee: attendee,
          );
        });
        return false;
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        title: Text(attendee.name),
        subtitle: Text(attendee.emailAddress),
        trailing: Text(attendee.isOrganiser ? 'Organizser' : ''),
      ),
    );
  }
}

Future<List<Attendee>?> _getAttendees(String eventId) async {
  var widget;
  return await widget.calendarPlugin.getAttendees(eventId: eventId);
}

_addAttendee(String eventId) async {
  var number = Random().nextInt(100);
  var newAttendee = Attendee(
      name: 'Attendee$number', emailAddress: 'attendee$number@gmail.com');
  var widget;
  await widget.calendarPlugin
      .addAttendees(eventId: eventId, newAttendee: [newAttendee]);
}
