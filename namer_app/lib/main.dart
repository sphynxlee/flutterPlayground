import 'package:flutter/material.dart';
import 'inputChips/input_chips_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Chips Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Chips Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InputChipsWidget(
            hintText: 'Add hardware',
            onChipAdded: (value) {
              print('Chips: $value');
            }),
      ),
    );
  }
}
