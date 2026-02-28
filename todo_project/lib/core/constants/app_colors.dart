import 'package:flutter/material.dart';

/// Centralized color constants for the app
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Gradient colors
  static const Color gradientStart = Color(0xFF4A90E2); // Blue
  static const Color gradientEnd = Color(0xFF50C878); // Green

  // Card colors
  static const Color cardBackground = Colors.white;
  static const Color cardShadow = Color(0x1A000000);

  // Title colors
  static const Color titleText = Colors.black87;
  static const Color titleIcon = Color(0xFF50C878); // Green

  // Input colors
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFill = Colors.white;
  static const Color inputHint = Colors.grey;

  // Button colors
  static const Color addButton = Color(0xFF4A90E2); // Blue
  static const Color deleteButton = Color(0xFFE74C3C); // Red
  static const Color buttonText = Colors.white;

  // Todo item colors
  static const Color todoItemBackground = Color(0xFFF5F5F5); // Light grey
  static const Color todoText = Colors.black87;
  static const Color todoTextCompleted = Colors.grey;
  static const Color checkboxBorder = Colors.grey;
  static const Color checkboxActive = Color(0xFF50C878); // Green
}
