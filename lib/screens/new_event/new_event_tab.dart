import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/network/event_service.dart';
import 'package:evenlty_app/screens/new_event/map_picker_location.dart';
import 'package:evenlty_app/screens/new_event/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class NewEventTab extends StatefulWidget {
  const NewEventTab({super.key});
  static const String routeName = "newEventTab";

  @override
  State<NewEventTab> createState() => _NewEventTabState();
}

class _NewEventTabState extends State<NewEventTab> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CategoryModel selectedCategory = CategoryModel.Catagories[1];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  LatLng? pickedLocation;
  String locationText = "Select Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title Is Required";
                    }
                    return null;
                  },
                  hintText: "Event Title",
                  prefixIcon: const Icon(Icons.edit_calendar_rounded),
                ),
                CustomTextField(
                  label: "Description",
                  controller: desController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description Is Required";
                    }
                    return null;
                  },
                  hintText: "Event Description",
                  maxLines: 5,
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(width: 10),
                    Text(
                      "Event Date",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          setState(() => selectedDate = date);
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
                    const Icon(Icons.access_time_outlined),
                    const SizedBox(width: 10),
                    Text(
                      "Event Time",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() => selectedTime = time);
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
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MapPickerScreen(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        pickedLocation = result;
                        locationText =
                            "Lat: ${pickedLocation!.latitude.toStringAsFixed(4)}, Lng: ${pickedLocation!.longitude.toStringAsFixed(4)}";
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.maincolor,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.maincolor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            locationText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: AppColors.maincolor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomMainButton(
                  text: "Save",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (selectedDate != null &&
                          selectedTime != null &&
                          pickedLocation != null) {
                        selectedDate = selectedDate!.copyWith(
                          hour: selectedTime!.hour,
                          minute: selectedTime!.minute,
                        );
                        EventModel eventmodel = EventModel(
                          title: titleController.text,
                          date: DateFormat(
                            "yyyy-MM-dd hh:mm",
                          ).format(selectedDate!),
                          description: desController.text,
                          isFav: false,
                          catId: selectedCategory.id,
                          location: locationText,
                          latitude: pickedLocation!.latitude,
                          longitude: pickedLocation!.longitude,
                        );
                        try {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Center(
                              child: Container(
                                padding: const EdgeInsets.all(50),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                          );
                          await EventService.creatNewEvent(eventmodel);
                          Fluttertoast.showToast(
                            msg: "Event Added",
                            backgroundColor: Colors.green,
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: e.toString(),
                            backgroundColor: AppColors.loginbuttoncolor,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Date, Time and Location are required",
                          backgroundColor: AppColors.loginbuttoncolor,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
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
