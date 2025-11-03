import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/common/widgets/custom_main_button.dart';
import 'package:evenlty_app/common/widgets/custom_textfield.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:evenlty_app/screens/new_event/map_picker_location.dart';
import 'package:evenlty_app/screens/new_event/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditEventTab extends StatefulWidget {
  final EventModel eventModel;
  const EditEventTab({super.key, required this.eventModel});
  static const String routeName = "EventEditTab";

  @override
  State<EditEventTab> createState() => _EditEventTabState();
}

class _EditEventTabState extends State<EditEventTab> {
  late TextEditingController titleController;
  late TextEditingController desController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CategoryModel selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  LatLng? pickedLocation;
  String locationText = "Change Location";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.eventModel.title);
    desController = TextEditingController(text: widget.eventModel.description);

    selectedCategory = CategoryModel.Catagories.firstWhere(
      (cat) => cat.id == widget.eventModel.catId,
      orElse: () => CategoryModel.Catagories.first,
    );

    try {
      selectedDate = DateFormat("yyyy-MM-dd HH:mm").parse(widget.eventModel.date);
      selectedTime = TimeOfDay.fromDateTime(selectedDate!);
    } catch (_) {
      selectedDate = null;
      selectedTime = null;
    }

    if (widget.eventModel.location != null && widget.eventModel.location!.isNotEmpty) {
      locationText = widget.eventModel.location!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
   

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Edit Event"),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    selectedCategory.designPath ?? "",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                /// Category Selector
                CategorySelectorView(
                  onChanged: (category) {
                    setState(() => selectedCategory = category);
                  },
                  selectedCategory: selectedCategory,
                ),

                /// Title Input
                CustomTextField(
                  label: "Title",
                  controller: titleController,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Title is required" : null,
                  hintText: "Event Title",
                  prefixIcon: const Icon(Icons.edit_calendar_rounded),
                ),

                /// Description Input
                CustomTextField(
                  label: "Description",
                  controller: desController,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Description is required" : null,
                  hintText: "Event Description",
                  maxLines: 5,
                ),

                /// Date Row
                _buildDateRow(context, textTheme),

                /// Time Row
                _buildTimeRow(context, textTheme),

                /// Location Button (same style as NewEventTab)
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MapPickerScreen()),
                    );
                    if (result != null) {
                      setState(() {
                        pickedLocation = result;
                        locationText = "Selected location updated";
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.maincolor, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.maincolor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.location_on,
                              color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            locationText,
                            style: textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 18, color: AppColors.maincolor),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CustomMainButton(
                  text: "Save Changes",
                  onPressed: _saveChanges,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(BuildContext context, TextTheme textTheme) {
    return Row(
      children: [
        Icon(Icons.date_range, color: AppColors.maincolor),
        const SizedBox(width: 10),
        Text("Event Date", style: textTheme.titleMedium),
        const Spacer(),
        TextButton(
          onPressed: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (date != null) setState(() => selectedDate = date);
          },
          child: Text(
            _getDateText(),
            style: textTheme.titleMedium!.copyWith(color: AppColors.maincolor),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRow(BuildContext context, TextTheme textTheme) {
    return Row(
      children: [
        Icon(Icons.access_time_outlined, color: AppColors.maincolor),
        const SizedBox(width: 10),
        Text("Event Time", style: textTheme.titleMedium),
        const Spacer(),
        TextButton(
          onPressed: () async {
            TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (time != null) setState(() => selectedTime = time);
          },
          child: Text(
            _getTimeText(),
            style: textTheme.titleMedium!.copyWith(color: AppColors.maincolor),
          ),
        ),
      ],
    );
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      if (selectedDate != null && selectedTime != null && locationText.isNotEmpty) {
        selectedDate = selectedDate!.copyWith(
          hour: selectedTime!.hour,
          minute: selectedTime!.minute,
        );

        EventModel updatedEvent = EventModel(
          id: widget.eventModel.id,
          title: titleController.text,
          date: DateFormat("yyyy-MM-dd HH:mm").format(selectedDate!),
          description: desController.text,
          isFav: widget.eventModel.isFav,
          catId: selectedCategory.id,
          location: locationText,
          latitude: pickedLocation?.latitude,
          longitude: pickedLocation?.longitude,
        );

        try {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );

          await Provider.of<EventProvider>(context, listen: false)
              .editEvent(updatedEvent);

          Fluttertoast.showToast(
            msg: "Event Updated Successfully",
            backgroundColor: Colors.green,
          );
          Navigator.of(context).pop(updatedEvent);
        } catch (e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            backgroundColor: AppColors.loginbuttoncolor,
          );
          Navigator.of(context).pop();
        }
      } else {
        Fluttertoast.showToast(
          msg: "Date, Time, and Location are required",
          backgroundColor: AppColors.loginbuttoncolor,
        );
      }
    }
  }

  String _getTimeText() {
    if (selectedTime == null) return "Select Time";
    return selectedTime!.format(context);
  }

  String _getDateText() {
    if (selectedDate == null) return "Select Date";
    return DateFormat.yMEd().format(selectedDate!);
  }
}
