import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    String catImage=CategoryModel.Catagories.firstWhere((element)=>element.id==eventModel.catId).designPath!;
    return Container(
      height: 205,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(catImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Text(
              eventModel.date,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.maincolor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventModel.title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Icon(
                      eventModel.isFav
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: AppColors.maincolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
