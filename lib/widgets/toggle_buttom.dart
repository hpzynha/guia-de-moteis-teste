import 'package:flutter/material.dart';

class ToggleButtom extends StatefulWidget {
  const ToggleButtom({super.key});

  @override
  State<ToggleButtom> createState() => _ToggleButtomState();
}

class _ToggleButtomState extends State<ToggleButtom> {
  String selectedValue = 'ir agora';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SegmentedButton<String>(
        segments: const <ButtonSegment<String>>[
          ButtonSegment(
            value: 'ir agora',
            label: Text('🚀 ir agora'),
          ),
          ButtonSegment(
            value: 'ir outro dia',
            label: Text('📅 ir outro dia'),
          ),
        ],
        selected: {selectedValue},
        showSelectedIcon: false,
        onSelectionChanged: (newSelection) {
          setState(() {
            selectedValue = newSelection.first;
          });
        },
      ),
    );
  }
}
