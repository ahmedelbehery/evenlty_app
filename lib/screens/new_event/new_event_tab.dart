import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/screens/new_event/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewEventTab extends StatefulWidget {
  const NewEventTab({super.key});
  static const String routeName = "newEventTab";

  @override
  State<NewEventTab> createState() => _NewEventTabState();
}

class _NewEventTabState extends State<NewEventTab> {
  CategoryModel selectedCategory = CategoryModel.Catagories[1];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(
                selectedCategory.designPath!,
                height: 204,
                width: 360,
                fit: BoxFit.cover,
              ),
            ),
            CategorySelectorView(
              onChanged: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
              selectedCategory: selectedCategory,
            ),
            CustomTextField(
              label: "Title",
              hintText: "Event Title",
              prefixIcon: Icon(Icons.edit_calendar_rounded),
            ),
            CustomTextField(
              label: "Description",
              hintText: "Event Description",
              maxLines: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(width: 10),
                    Text(
                      "Event Date",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      },
                      child: Text(
                        _getDateText(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.maincolor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    SizedBox(width: 10),
                    Text(
                      "Event Time",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,

                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            selectedTime = time;
                          });
                        }
                      },
                      child: Text(
                        _getTimeText(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.maincolor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomMainButton(text: "Save", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  _getTimeText() {
    if (selectedTime == null) return "Select Time";
    return selectedTime!.format(context);
  }

  _getDateText() {
    if (selectedDate == null) return "Select Date";
    return DateFormat.yMEd().format(selectedDate!);
  }
}
