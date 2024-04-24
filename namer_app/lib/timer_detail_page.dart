import 'package:flutter/material.dart';
import 'timer_model.dart';
import 'timer_widget.dart';

class TimerDetailPage extends StatefulWidget {
  final TimerModel timer;

  const TimerDetailPage({Key? key, required this.timer}) : super(key: key);

  @override
  _TimerDetailPageState createState() => _TimerDetailPageState();
}

class _TimerDetailPageState extends State<TimerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Detail'),
      ),
      body: Center(
        child: TimerWidget(timer: widget.timer),
      ),
    );
  }
}