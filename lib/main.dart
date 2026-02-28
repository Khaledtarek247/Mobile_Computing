import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'features/todo/presentation/provider/todo_provider.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'BNTAREK Todo List',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const TodoPage(),
      ),
    );
  }
}
