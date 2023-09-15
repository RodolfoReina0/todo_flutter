import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final void Function(String) onSave;

  TaskDialog({
    required this.title,
    required this.hintText,
    required this.onSave,
  });

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _textController,
        decoration: InputDecoration(hintText: widget.hintText),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String newTitle = _textController.text;
            if (newTitle.isNotEmpty) {
              widget.onSave(newTitle);
              Navigator.of(context).pop(); // Close the dialog
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
