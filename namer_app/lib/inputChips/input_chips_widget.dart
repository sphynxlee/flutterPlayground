import 'package:flutter/material.dart';

class InputChipsWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<List<String>> onChipAdded;

  const InputChipsWidget({
    super.key,
    required this.hintText,
    required this.onChipAdded,
  });

  @override
  InputChipsWidgetState createState() => InputChipsWidgetState();
}

class InputChipsWidgetState extends State<InputChipsWidget> {
  final List<String> _chips = [];
  final TextEditingController _controller = TextEditingController();
  bool _isAddingNewChip = false;

  void _onChipAdded(String value) {
    setState(() {
      _chips.add(value);
      _controller.clear();
      _isAddingNewChip = false;
      widget.onChipAdded(_chips);
    });
  }

  void _onChipRemoved(String value) {
    setState(() {
      _chips.remove(value);
    });
  }

  void _onAddingNewChipChanged(bool value) {
    setState(() {
      _isAddingNewChip = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        if (_chips.isEmpty && !_isAddingNewChip)
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
            onFieldSubmitted: (value) {
              _onChipAdded(value);
            },
          ),
        ..._chips.map((chip) => Chip(
              label: Text(chip, style: const TextStyle(fontSize: 16, overflow: TextOverflow.clip)),
              labelStyle: const TextStyle(color: Color(0xFF1D2129)),
              backgroundColor: const Color(0xFFF7F8FA),
              onDeleted: () => _onChipRemoved(chip),
              deleteIconColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.transparent),
              ),
            )),
        if (_isAddingNewChip)
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
            onFieldSubmitted: (value) {
              _onChipAdded(value);
            },
          )
        else if (_chips.isNotEmpty)
          InputChip(
            label: const Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            labelStyle: const TextStyle(color: Color(0xFF1D2129)),
            backgroundColor: const Color(0xFFF7F8FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.transparent),
            ),
            onPressed: () {
              _onAddingNewChipChanged(true);
            },
          ),
      ],
    );
  }
}
