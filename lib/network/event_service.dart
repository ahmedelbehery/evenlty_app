import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenlty_app/models/event_model.dart';

class EventService {
  static Future<void> creatNewEvent(EventModel event) async {
    final collection = getEventsCollection();
    final doc = collection.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<List<EventModel>> getAllEvents() async {
    final collection = getEventsCollection();
    final snapshot = await collection.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Future<void> updateEvent(EventModel event) async {
    if (event.id == null) throw Exception("Event ID is missing.");
    final collection = getEventsCollection();
    await collection.doc(event.id).update(event.tojson());
  }

  static Future<void> deleteEvent(String eventId) async {
    final collection = getEventsCollection();
    await collection.doc(eventId).delete();
  }

  static CollectionReference<EventModel> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection("events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }
}
