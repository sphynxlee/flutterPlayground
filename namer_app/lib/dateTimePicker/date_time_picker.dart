import 'package:flutter/cupertino.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  // DateTime date = DateTime(2016, 10, 26);
  // DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime startDateTime = DateTime.now();

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoDatePicker Sample'),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // _DatePickerItem(
              //   children: <Widget>[
              //     const Text('Date'),
              //     CupertinoButton(
              //       // Display a CupertinoDatePicker in date picker mode.
              //       onPressed: () => _showDialog(
              //         CupertinoDatePicker(
              //           initialDateTime: date,
              //           mode: CupertinoDatePickerMode.date,
              //           use24hFormat: true,
              //           // This shows day of week alongside day of month
              //           showDayOfWeek: true,
              //           // This is called when the user changes the date.
              //           onDateTimeChanged: (DateTime newDate) {
              //             setState(() => date = newDate);
              //           },
              //         ),
              //       ),
              //       // In this example, the date is formatted manually. You can
              //       // use the intl package to format the value based on the
              //       // user's locale settings.
              //       child: Text(
              //         '${date.month}-${date.day}-${date.year}',
              //         style: const TextStyle(
              //           fontSize: 22.0,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // _DatePickerItem(
              //   children: <Widget>[
              //     const Text('Time'),
              //     CupertinoButton(
              //       // Display a CupertinoDatePicker in time picker mode.
              //       onPressed: () => _showDialog(
              //         CupertinoDatePicker(
              //           initialDateTime: time,
              //           mode: CupertinoDatePickerMode.time,
              //           use24hFormat: true,
              //           // This is called when the user changes the time.
              //           onDateTimeChanged: (DateTime newTime) {
              //             setState(() => time = newTime);
              //           },
              //         ),
              //       ),
              //       // In this example, the time value is formatted manually.
              //       // You can use the intl package to format the value based on
              //       // the user's locale settings.
              //       child: Text(
              //         '${time.hour}:${time.minute}',
              //         style: const TextStyle(
              //           fontSize: 22.0,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              _DatePickerItem(
                children: <Widget>[
                  const Text('Start Date Time'),
                  CupertinoButton(
                      // Display a CupertinoDatePicker in startDateTime picker mode.
                      onPressed: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: startDateTime,
                              use24hFormat: true,
                              // This is called when the user changes the startDateTime.
                              onDateTimeChanged: (DateTime newDateTime) {
                                setState(() => startDateTime = newDateTime);
                              },
                            ),
                          ),
                      // In this example, the time value is formatted manually. You
                      // can use the intl package to format the value based on the
                      // user's locale settings.
                      child: Container(
                        width: 300, // Set this to whatever width suits your layout
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          // '${startDateTime.month}-${startDateTime.day}-${startDateTime.year} ${startDateTime.hour}:${startDateTime.minute}',
                          formatDate(startDateTime),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                          softWrap: true,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This class simply decorates a row of widgets.
class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}

String formatDate(DateTime dateTime) {
  // Array of weekday names
  List<String> weekdays = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sunday"];

  // Array of month names
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];

  // Building the formatted string
  String weekday = weekdays[dateTime.weekday - 1];
  String month = months[dateTime.month - 1];
  int day = dateTime.day;
  int year = dateTime.year;
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  return "$weekday $month $day $year ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}
