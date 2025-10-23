import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenlty_app/models/event_model.dart';

class EventService {
  
  static Future<void> creatNewEvent(EventModel event) async {
    CollectionReference<EventModel> collection = getEventsCollection();
    DocumentReference<EventModel> doc = collection.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<List<EventModel>> getAllEvents() async {
    CollectionReference<EventModel> collection = getEventsCollection();
    QuerySnapshot<EventModel> snapshot = await collection.get();
    List<EventModel> events = snapshot.docs.map((e) => e.data()).toList();
    return events;
  }

  static getEventsCollection() {
    CollectionReference<EventModel> collection = FirebaseFirestore.instance
        .collection("events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
    return collection;
  }
}
