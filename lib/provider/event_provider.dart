import 'package:flutter/material.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/network/event_service.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> _events = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<EventModel> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getEvents() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _events = await EventService.getAllEvents();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void addEvent(EventModel event) {
    _events.insert(0, event);
    notifyListeners();
  }

  void clear() {
    _events.clear();
    notifyListeners();
  }

  int _selectedId = 0;
  int get selectedId => _selectedId;

  void selectCategory(int id) {
    _selectedId = id;
    notifyListeners();
  }

  Future<void> editEvent(EventModel updatedEvent) async {
    try {
      await EventService.updateEvent(updatedEvent); 
      final index = _events.indexWhere((e) => e.id == updatedEvent.id);
      if (index != -1) {
        _events[index] = updatedEvent;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await EventService.deleteEvent(eventId); 
      _events.removeWhere((e) => e.id == eventId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
  void updateEventInList(EventModel updatedEvent) {
  final index = _events.indexWhere((e) => e.id == updatedEvent.id);
  if (index != -1) {
    _events[index] = updatedEvent;
    notifyListeners();
  }
}

}
