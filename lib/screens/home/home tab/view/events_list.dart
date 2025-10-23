import 'package:evenlty_app/common/widgets/event_card.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:flutter/material.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.events});
 final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(eventModel: events[index],);
        },
      ),
    );
  }
}
