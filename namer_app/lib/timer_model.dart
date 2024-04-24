class TimerModel {
  final String id; // Unique identifier for the timer
  DateTime? startTime; // Start time of the timer
  DateTime? endTime; // End time of the timer (null if not set)
  bool isRunning; // Flag to track if the timer is running

  TimerModel({
    required this.id,
    this.startTime,
    this.endTime,
    this.isRunning = false,
  });

  // Methods to start, stop, and reset the timer
  void start() {
    startTime = DateTime.now();
    isRunning = true;
  }

  void stop() {
    endTime = DateTime.now();
    isRunning = false;
  }

  void reset() {
    startTime = null;
    endTime = null;
    isRunning = false;
  }

  // // Method to get the elapsed time
  // Duration get elapsedTime {
  //   if (!isRunning) {
  //     return endTime!.difference(startTime!);
  //   } else {
  //     return DateTime.now().difference(startTime!);
  //   }
  // }

  Duration get elapsedTime {
    if (!isRunning) {
      if (startTime != null && endTime != null) {
        return endTime!.difference(startTime!);
      } else {
        return Duration.zero;
      }
    } else {
      if (startTime != null) {
        return DateTime.now().difference(startTime!);
      } else {
        return Duration.zero;
      }
    }
  }
}
