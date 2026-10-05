import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String hint;
  final String buttonText;
  final String initialText;
  final bool showBackButton;
  final IconData? icon;
  final int lines;
  final Function(String) onSave;

  CustomForm({
    required this.title,
    required this.hint,
    required this.buttonText,
    required this.onSave,
    this.subtitle,
    this.initialText = '',
    this.showBackButton = false,
    this.icon,
    this.lines = 1,

  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: widget.showBackButton),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),

            // title (and the icon on the right if there is one)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (widget.icon != null) Icon(widget.icon, size: 22),
              ],
            ),

            if (widget.subtitle != null) ...[
              SizedBox(height: 8),
              Text(widget.subtitle!, style: TextStyle(color: Colors.grey)),
            ],
            SizedBox(height: 16),

            TextField(
              controller: controller,
              maxLines: widget.lines,
              decoration: InputDecoration(
                hintText: widget.hint,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4DB8F5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  String text = controller.text.trim();
                  if (text.isEmpty) return; // do nothing if empty
                  widget.onSave(text);
                },
                child: Text(widget.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}