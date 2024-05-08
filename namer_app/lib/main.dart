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
  bool _isAddingNewChip = false;

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
          isAddingNewChip: _isAddingNewChip,
          onChipAdded: _addChip,
          onChipRemoved: _removeChip,
          onAddingNewChipChanged: _setAddingNewChipState,
        ),
      ),
    );
  }

  void _addChip(String value) {
    setState(() {
      _chips.add(value);
      _controller.clear();
      _isAddingNewChip = false;
    });
  }

  void _removeChip(String value) {
    setState(() {
      _chips.remove(value);
    });
  }

  void _setAddingNewChipState(bool value) {
    setState(() {
      _isAddingNewChip = value;
    });
  }
}

class InputChipsWidget extends StatefulWidget {
  final List<String> chips;
  final TextEditingController controller;
  final bool isAddingNewChip;
  final Function(String) onChipAdded;
  final Function(String) onChipRemoved;
  final Function(bool) onAddingNewChipChanged;

  InputChipsWidget({
    required this.chips,
    required this.controller,
    required this.isAddingNewChip,
    required this.onChipAdded,
    required this.onChipRemoved,
    required this.onAddingNewChipChanged,
  });

  @override
  InputChipsWidgetState createState() => InputChipsWidgetState();
}

class InputChipsWidgetState extends State<InputChipsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        if (widget.chips.isEmpty && !widget.isAddingNewChip)
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: 'Add hardware',
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 16),
            onFieldSubmitted: (value) {
              widget.onChipAdded(value);
            },
          ),
        ...widget.chips
            .map((chip) => Chip(
                  label: Text(chip, style: TextStyle (fontSize: 16, overflow: TextOverflow.clip)),
                  labelStyle: const TextStyle(color: Color(0xFF1D2129)),
                  backgroundColor: const Color(0xFFF7F8FA),
                  onDeleted: () => widget.onChipRemoved(chip),
                  deleteIconColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                ))
            .toList(),
        if (widget.isAddingNewChip)
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: 'Add hardware',
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 16),
            onFieldSubmitted: (value) {
              widget.onChipAdded(value);
            },
          )
        else if (widget.chips.isNotEmpty)
          InputChip(
            label: Text('+',style: TextStyle (fontWeight: FontWeight.bold, fontSize: 16)),
            labelStyle: const TextStyle(color: Color(0xFF1D2129)),
            backgroundColor: const Color(0xFFF7F8FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.transparent),
            ),
            onPressed: () {
              widget.onAddingNewChipChanged(true);
            },
          ),
      ],
    );
  }
}
