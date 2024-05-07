import 'package:flutter/material.dart';
import 'timer_manager.dart';
import 'timer_model.dart';
import 'timer_widget.dart';
import 'timer_detail_page.dart';

class TimerListPage extends StatefulWidget {
  const TimerListPage({Key? key}) : super(key: key);

  @override
  _TimerListPageState createState() => _TimerListPageState();
}

class _TimerListPageState extends State<TimerListPage> {
  final TimerManager _timerManager = TimerManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer List'),
      ),
      body: ListView.builder(
        itemCount: _timerManager.timers.length,
        itemBuilder: (context, index) {
          final timer = _timerManager.timers[index];
          return ListTile(
            title: TimerWidget(
              timer: timer,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    if (!timer.isRunning) {
                      timer.start();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    if (timer.isRunning) {
                      timer.stop();
                      _timerManager.removeTimer(timer);
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimerDetailPage(timer: timer),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final newTimer = TimerModel(id: DateTime.now().toString());
          _timerManager.addTimer(newTimer);
          setState(() {});
        },
      ),
    );
  }

  void _stopTimers() {
    for (final timer in _timerManager.timers) {
      if (timer.isRunning) {
        timer.stop();
      }
    }
  }
}