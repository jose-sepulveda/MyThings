import 'package:flutter/foundation.dart';

class CalendarState extends ChangeNotifier {
  String? _chosenCalendarId;

  String? get chosenCalendarId => _chosenCalendarId;

  set chosenCalendarId(String? id) {
    _chosenCalendarId = id;
    notifyListeners();
  }
}
