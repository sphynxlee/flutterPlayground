import 'package:flutter/material.dart';

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
  final List<String> _chips = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Chips Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InputChipsWidget(
          chips: _chips,
          controller: _controller,
          onChipAdded: _addChip,
        ),
      ),
    );
  }

  void _addChip(String value) {
    setState(() {
      _chips.add(value);
      _controller.clear();
    });
  }
}

class InputChipsWidget extends StatefulWidget {
  final List<String> chips;
  final TextEditingController controller;
  final Function(String) onChipAdded;

  InputChipsWidget({
    required this.chips,
    required this.controller,
    required this.onChipAdded,
  });

  @override
  _InputChipsWidgetState createState() => _InputChipsWidgetState();
}

class _InputChipsWidgetState extends State<InputChipsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        if (widget.chips.isEmpty)
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: 'Add hardware',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              widget.onChipAdded(value);
            },
          )
        else
          ...widget.chips.map((chip) => Chip(label: Text(chip))).toList(),
        if (widget.chips.isNotEmpty)
          InputChip(
            label: Text('+'),
            onPressed: () {
              _showInputDialog();
            },
          ),
      ],
    );
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Input'),
          content: TextField(
            controller: widget.controller,
            decoration: InputDecoration(hintText: 'Enter input'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onChipAdded(widget.controller.text);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}