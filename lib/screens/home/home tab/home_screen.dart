import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/screens/home/home%20tab/view/events_list.dart';
import 'package:evenlty_app/screens/home/home%20tab/view/home_header.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<EventModel> events = List.generate(
      5,
      (index) => EventModel(
        title: "title$index",
        date: "22\nJAN",
        description: "description",
        isFav: index % 2 == 0,
        catId: 2,
      ),
    );
    return Column(
      children: [
        HomeHeader(),
        EventsListView(events: events),
      ],
    );
  }
}
