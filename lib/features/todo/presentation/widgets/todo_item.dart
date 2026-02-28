import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/todo_model.dart';
import '../provider/todo_provider.dart';

/// Widget representing a single todo item with checkbox and delete button
class TodoItem extends StatelessWidget {
  final TodoModel todo;

  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.todoItemDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Checkbox
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) {
                  context.read<TodoProvider>().toggleTodoStatus(todo.id);
                },
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Todo text
            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: todo.isCompleted
                      ? AppColors.todoTextCompleted
                      : AppColors.todoText,
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Delete button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showDeleteConfirmation(context);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColors.deleteButton,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a confirmation dialog before deleting a todo
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Todo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this todo?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TodoProvider>().deleteTodo(todo.id);
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deleteButton,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
