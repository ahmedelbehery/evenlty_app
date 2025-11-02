import 'package:evenlty_app/common/app_colors.dart';
import 'package:evenlty_app/models/category_model.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});
  static const String routeName = "/LocationTab";

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  String? _style;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  String? _selectedMarkerId;

  Future<void> _loadMapStyle() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stylePath = isDark
        ? "assets/map_style/dark_map.json"
        : "assets/map_style/light_map.json";
    final style = await rootBundle.loadString(stylePath);
    setState(() => _style = style);
    if (_mapController != null) {
      _mapController?.setMapStyle(_style);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadMapStyle();
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              if (_style != null) _mapController?.setMapStyle(_style);
              _addEventMarkers(eventProvider);
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357),
              zoom: 12,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: 60,
            right: 20,
            child: FloatingActionButton(
              heroTag: "locate",
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    const LatLng(30.0444, 31.2357),
                    14,
                  ),
                );
              },
              backgroundColor: AppColors.maincolor,
              child: Icon(
                Icons.navigation_rounded,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200,
              child: eventProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: eventProvider.events.length,
                      itemBuilder: (context, index) {
                        final event = eventProvider.events[index];
                        final category = CategoryModel.Catagories.firstWhere(
                          (c) => c.id == event.catId,
                        );
                        final isSelected = _selectedMarkerId == event.id;
                        return GestureDetector(
                          onTap: () {
                            if (event.latitude != null &&
                                event.longitude != null) {
                              final markerId = event.id ?? event.title;
                              setState(() => _selectedMarkerId = markerId);
                              _mapController?.animateCamera(
                                CameraUpdate.newLatLngZoom(
                                  LatLng(event.latitude!, event.longitude!),
                                  16,
                                ),
                              );
                              _mapController?.showMarkerInfoWindow(
                                MarkerId(markerId),
                              );
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 280,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue[50]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    category.designPath!,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: isSelected
                                              ? AppColors.maincolor
                                              : AppColors.darkbgcolor,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.blueAccent,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              event.location ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _addEventMarkers(EventProvider eventProvider) {
    _markers.clear();
    for (var event in eventProvider.events) {
      if (event.latitude != null && event.longitude != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(event.id ?? event.title),
            position: LatLng(event.latitude!, event.longitude!),
            infoWindow: InfoWindow(
              title: event.title,
              snippet: event.location ?? "",
            ),
          ),
        );
      }
    }
    setState(() {});
  }
}
