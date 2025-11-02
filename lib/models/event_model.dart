class EventModel {
  String? id;
  String title;
  String date;
  String description;
  bool isFav;
  int catId;
  String? location;
  final double? latitude;
  final double? longitude;

  EventModel({
    required this.title,
    required this.date,
    required this.description,
    required this.isFav,
    required this.catId,
    this.id,
    this.location,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "title": title,
      "date": date,
      "description": description,
      "isFav": isFav,
      "catId": catId,
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      title: json["title"],
      date: json["date"],
      description: json["description"],
      isFav: json["isFav"],
      catId: json["catId"],
      location: json["location"],
      latitude: (json["latitude"] != null)
          ? (json["latitude"] as num).toDouble()
          : null,
      longitude: (json["longitude"] != null)
          ? (json["longitude"] as num).toDouble()
          : null,
    );
  }
}
