import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/todo_card.dart';

/// Main page for the Todo application
/// Contains the gradient background and centered todo card
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: const TodoCard(),
            ),
          ),
        ),
      ),
    );
  }
}
