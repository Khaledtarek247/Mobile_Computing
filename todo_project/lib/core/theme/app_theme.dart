import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Centralized theme configuration for the app
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: 'Roboto',

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.addButton, width: 2),
        ),
        hintStyle: TextStyle(color: AppColors.inputHint.withOpacity(0.6)),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.addButton,
          foregroundColor: AppColors.buttonText,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.checkboxActive;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: AppColors.checkboxBorder, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Text theme
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.titleText,
          letterSpacing: 1.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.todoText,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.todoText),
      ),
    );
  }

  // Gradient decoration for background
  static BoxDecoration get gradientBackground {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gradientStart, AppColors.gradientEnd],
      ),
    );
  }

  // Card decoration
  static BoxDecoration cardDecoration({double elevation = 8}) {
    return BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: elevation * 2,
          spreadRadius: elevation / 2,
          offset: Offset(0, elevation / 2),
        ),
      ],
    );
  }

  // Todo item decoration
  static BoxDecoration todoItemDecoration() {
    return BoxDecoration(
      color: AppColors.todoItemBackground,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
