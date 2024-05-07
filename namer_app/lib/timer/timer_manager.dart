import 'timer_model.dart';

class TimerManager {
  final List<TimerModel> _timers = [];

  // Method to add a new timer
  void addTimer(TimerModel timer) {
    _timers.add(timer);
  }

  // Method to remove a timer
  void removeTimer(TimerModel timer) {
    _timers.remove(timer);
  }

  // Method to get all active timers
  List<TimerModel> get timers => _timers;
}