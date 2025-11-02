import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:evenlty_app/provider/user_provider.dart';
import 'package:evenlty_app/screens/home/home%20tab/view/events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).userModel;
    List<EventModel> favEvents = user?.favEvents ?? [];

    List<EventModel> filteredEvents = favEvents.where((event) {
      final title = event.title.toLowerCase();
      final query = searchQuery.toLowerCase();
      return _normalizeText(title).contains(_normalizeText(query));
    }).toList();

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
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(child: EventsListView(events: filteredEvents))
        ],
      ),
    );
  }

  String _normalizeText(String text) {
    return text
        .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .trim();
  }
}
