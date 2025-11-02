import 'package:evenlty_app/screens/new_event/event_edit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.event});
  static const String routeName = "EventDetails";
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final category = CategoryModel.Catagories.firstWhere(
      (c) => c.id == event.catId,
      orElse: () => CategoryModel.Catagories.first,
    );

    final LatLng? eventLocation = (event.latitude != null && event.longitude != null)
        ? LatLng(event.latitude!, event.longitude!)
        : null;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Event Details"),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditEventTab.routeName,
                arguments: event,
              );
            },
            icon: Icon(Icons.edit, color: theme.colorScheme.primary),
          ),
          IconButton(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: theme.dialogBackgroundColor,
                  title: const Text("Delete Event"),
                  content: const Text("Are you sure you want to delete this event?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text("Delete", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirm == true && event.id != null && context.mounted) {
                await Provider.of<EventProvider>(context, listen: false)
                    .deleteEvent(event.id!);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  category.designPath!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  event.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              _buildInfoCard(
                context,
                icon: Icons.date_range,
                title: _getFormattedDate(event.date),
                subtitle: _getFormattedTime(event.date),
                backgroundColor: theme.scaffoldBackgroundColor,
              ),

              if (event.location != null && event.location!.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 12),

                    // 📍 Location Card
                    _buildInfoCard(
                      context,
                      icon: Icons.location_on,
                      title: event.location!,
                      subtitle: null,
                      backgroundColor: theme.scaffoldBackgroundColor,
                    ),
                    const SizedBox(height: 16),

                    // 🗺 Map
                    if (eventLocation != null)
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: eventLocation,
                            zoom: 14,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId(event.id ?? event.title),
                              position: eventLocation,
                              infoWindow: InfoWindow(
                                title: event.title,
                                snippet: event.location ?? "",
                              ),
                            ),
                          },
                          zoomControlsEnabled: false,
                          scrollGesturesEnabled: false,
                          rotateGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          myLocationButtonEnabled: false,
                          mapToolbarEnabled: false,
                        ),
                      ),
                  ],
                ),

              const SizedBox(height: 20),

              // 📝 Description
              Text(
                "Description",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required Color backgroundColor,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                if (subtitle != null)
                  Text(subtitle,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";
    try {
      final date = DateFormat("yyyy-MM-dd HH:mm").parse(dateString);
      return DateFormat("dd MMMM yyyy").format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _getFormattedTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";
    try {
      final date = DateFormat("yyyy-MM-dd HH:mm").parse(dateString);
      return DateFormat("hh:mm a").format(date);
    } catch (e) {
      return dateString;
    }
  }
}
