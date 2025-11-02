import 'package:flutter/material.dart';
import 'package:evenlty_app/common/widgets/event_card.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/event_details.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.events});
  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              EventDetails.routeName,
              arguments: event,
            );
          },
          child: EventCard(eventModel: event),
        );
      },
    );
  }
}
