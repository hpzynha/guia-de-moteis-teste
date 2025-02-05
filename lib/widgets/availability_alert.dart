import 'package:flutter/material.dart';

class AvailabilityAlert extends StatelessWidget {
  final int remaining;

  const AvailabilityAlert({super.key, required this.remaining});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.orange[800],
            size: 18,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Só mais $remaining pelo app",
            style: TextStyle(
              color: Colors.orange[800],
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
