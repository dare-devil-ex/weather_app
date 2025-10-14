// ignore_for_file: file_names
import 'package:flutter/material.dart';

class Additional extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const Additional({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontWeight: FontWeight.normal)),
        SizedBox(height: 5),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
