// lib/views/widgets/info_card.dart

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String value;
  final String unit;
  final String message;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback? onTap;
  final Widget? child;

  const InfoCard({
    super.key,
    required this.value,
    required this.unit,
    required this.message,
    required this.primaryColor,
    required this.secondaryColor,
    this.onTap,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  color: primaryColor,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        unit,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}