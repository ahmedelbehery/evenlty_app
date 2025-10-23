class EventModel {
  String? id;
  String title;
  String date;
  String description;
  bool isFav;
  int catId;
  EventModel({
    required this.title,
    required this.date,
    required this.description,
    required this.isFav,
    required this.catId,
    this.id,
  });
  Map<String, dynamic> tojson() {
    return {
      "title": title,
      "id":id,
      "date": date,
      "description": description,
      "isFav": isFav,
      "catId": catId,
    };
  }

  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json["title"],
      id: json["id"],
      date: json["date"],
      description: json["description"],
      isFav: json["isFav"],
      catId: json["catId"],
    );
  }
}
