import 'package:flutter/material.dart';
import 'dart:async';

class DataProvider extends ChangeNotifier {
  late Timer _timer;
  late Duration fullDuration;
  late Duration lapDuration;
  int _milliseconds = 0;
  int _lapMilliseconds = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  bool _running = false;
  bool _lapsCleared = false;
  final List<String> _items = [];

  int get milliseconds => _milliseconds;
  List<String> get items => _items;

  void startTimer() {
    if (!_running) {
      _running = true;
      _lapsCleared = false;
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _milliseconds += 100;
        !_lapsCleared ? _lapMilliseconds += 100 : "";
        fullDuration = Duration(milliseconds: _milliseconds);
        hours = fullDuration.inHours;
        minutes = fullDuration.inMinutes % 60;
        seconds = fullDuration.inSeconds % 60;
        _lapsCleared
            ? ""
            : items.isEmpty
                ? items.add(formattedLapTime)
                : _items[0] = formattedLapTime;
        notifyListeners();
      });
    }
  }

  void pauseTimer() {
    _timer.cancel();
    _running = false;
    _lapsCleared = false;
  }

  void resetTimer() {
    _timer.cancel();
    _milliseconds = 0;
    hours = 0;
    minutes = 0;
    seconds = 0;
    _items.clear();
    _running = false;
    _lapsCleared = false;
    notifyListeners();
  }

  void addItemToList() {
    _items.insert(0, formattedLapTime);
    _lapMilliseconds = 0;
    _lapsCleared = false;
    notifyListeners();
  }

  void clearList() {
    _items.clear();
    _lapsCleared = true;
    _lapMilliseconds = 0;
    notifyListeners();
  }

  String get formattedTime {
    return formatTime(_milliseconds);
  }

  String get formattedLapTime {
    return formatTime(_lapMilliseconds);
  }

  String formatTime(int inputTime) {
    Duration duration = Duration(milliseconds: inputTime);
    String hoursStr = duration.inHours.toString().padLeft(2, '0');
    String minutesStr = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String secondsStr = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String millisecondsStr = ((duration.inMilliseconds ~/ 100) % 10).toString();

    return '$hoursStr:$minutesStr:$secondsStr.$millisecondsStr';
  }
}