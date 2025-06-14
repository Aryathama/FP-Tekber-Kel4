// lib/views/widgets/macro_nutrient_item.dart

import 'package:flutter/material.dart';

class MacroNutrientItem extends StatelessWidget {
  final String name;
  final String value;
  final Color color;

  const MacroNutrientItem({
    super.key,
    required this.name,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}