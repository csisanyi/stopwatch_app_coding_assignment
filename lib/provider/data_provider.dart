import 'package:flutter/material.dart';
import 'dart:async';

class DataProvider extends ChangeNotifier {
  late Timer _timer;
  late Duration fullDuration;
  late Duration lapDuration;
  int _milliseconds = 0;
  int _lapMilliseconds = 0;
  int clocked = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  bool _lapsCleared = false;
  final List<String> _items = [];
  Stopwatch stopwatch = Stopwatch();
  String formattedTime = "00:00:00.0";
  String formattedLapTime = "00:00:00.0";

  int get milliseconds => _milliseconds;
  List<String> get items => _items;

  void startTimer() {
    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _milliseconds = stopwatch.elapsed.inMilliseconds;
      _lapMilliseconds = milliseconds - clocked;
      formattedTime = formatTime(_milliseconds);
      formattedLapTime = formatTime(_lapMilliseconds);
      fullDuration = Duration(milliseconds: milliseconds);
      hours = fullDuration.inHours;
      minutes = fullDuration.inMinutes % 60;
      seconds = fullDuration.inSeconds % 60;
      _lapsCleared
          ? ""
          : items.isEmpty
              ? items.add(formattedLapTime)
              : items[0] = formattedLapTime;
      notifyListeners();
    });
  }


  void pauseTimer() {
    _timer.cancel();
    stopwatch.stop();
    _lapsCleared = false;
  }

  void resetTimer() {
    _timer.cancel();
    stopwatch.stop();
    stopwatch.reset();
    _milliseconds = 0;
    formattedTime = formatTime(_milliseconds);
    clocked = 0;
    hours = 0;
    minutes = 0;
    seconds = 0;
    _items.clear();
    notifyListeners();
  }

  void addItemToList() {
    clocked += stopwatch.elapsed.inMilliseconds;
    _items.insert(0, formattedLapTime);
    _lapsCleared = false;
    notifyListeners();
  }

  void clearList() {
    _items.clear();
    _lapsCleared = true;
    notifyListeners();
  }

  String get getFormattedTime {
    return formatTime(_milliseconds);
  }

  String get getFormattedLapTime {
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
