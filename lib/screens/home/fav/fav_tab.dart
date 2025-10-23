import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/screens/home/home%20tab/view/events_list.dart';
import 'package:flutter/material.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<EventModel> events = List.generate(
      4,
      (index) => EventModel(
        title: "title$index",
        date: "22\nJAN",
        description: "description",
        isFav: index % 2 == 0,
        catId: index+2,
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              hintText: "Search For Event",
              prefixIcon: Icon(Icons.search, color: AppColors.maincolor),
              borderColor: AppColors.maincolor,
              hintColor: AppColors.maincolor,
            ),
          ),
          EventsListView(events: events) 
        ],
      ),
    );
  }
}
