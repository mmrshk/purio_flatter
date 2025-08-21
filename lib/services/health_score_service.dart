import 'package:flutter/material.dart';

class HealthScoreService {
  /// Get health score color based on the 4-color system from Scoring Method page
  static Color getHealthScoreColor(int score) {
    if (score >= 90) {
      return const Color(0xFF2ECC71); // Excellent - Green
    } else if (score >= 70) {
      return const Color(0xFF40A5A5); // Good - Teal
    } else if (score >= 50) {
      return const Color(0xFFFFA500); // Fair - Orange
    } else {
      return const Color(0xFFE74C3C); // Poor - Red
    }
  }
}
