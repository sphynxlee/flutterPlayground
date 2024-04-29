import 'package:flutter/material.dart';
import 'dart:async';
import 'timer_model.dart';

class TimerWidget extends StatefulWidget {
  final TimerModel timer;

  const TimerWidget({
    Key? key,
    required this.timer,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _elapsedTimeTimer;
  late Timer _fiveSecondTimer;

  @override
  void initState() {
    super.initState();
    _startElapsedTimeTimer();
    _startFiveSecondTimer();
  }

  @override
  void dispose() {
    _stopTimers();
    super.dispose();
  }

  void _stopTimers() {
    if (_elapsedTimeTimer.isActive) {
      _elapsedTimeTimer.cancel();
    }
    if (_fiveSecondTimer.isActive) {
      _fiveSecondTimer.cancel();
    }
  }

  void _startElapsedTimeTimer() {
    _elapsedTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.timer.isRunning) {
        if (mounted) {
          print('`````````````````One second elapsed');
          setState(() {});
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _startFiveSecondTimer() {
    _fiveSecondTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (widget.timer.isRunning) {
        if (mounted) {
          print('Five seconds elapsed');
          setState(() {});
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTime = widget.timer.elapsedTime;
    if (elapsedTime == Duration.zero) {
      return const Text('Timer not started');
    }
    return Text(
      _formatDuration(elapsedTime),
      style: const TextStyle(fontSize: 24),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
