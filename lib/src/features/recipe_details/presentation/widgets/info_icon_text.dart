import 'package:flutter/material.dart';

class InfoIconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const InfoIconText({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.green[400], size: 26),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
