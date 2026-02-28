import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../provider/todo_provider.dart';
import 'todo_item.dart';

/// Main card widget containing the todo list UI
class TodoCard extends StatefulWidget {
  const TodoCard({super.key});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTodo() {
    final provider = context.read<TodoProvider>();
    final success = provider.addTodo(_textController.text);
    
    if (success) {
      _textController.clear();
      _focusNode.unfocus();
      
      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todo added successfully!'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // Show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid todo'),
          backgroundColor: AppColors.deleteButton,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: AppTheme.cardDecoration(elevation: 8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title section
            _buildTitle(),
            
            const SizedBox(height: 24),
            
            // Input section
            _buildInputSection(),
            
            const SizedBox(height: 24),
            
            // Todo list section
            _buildTodoList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.titleIcon.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle,
            color: AppColors.titleIcon,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'REACT TODO LIST',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                letterSpacing: 1.5,
              ),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              hintText: 'Add a new todo',
              isDense: true,
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _addTodo(),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _addTodo,
          child: const Text('Add'),
        ),
      ],
    );
  }

  Widget _buildTodoList() {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        if (todoProvider.todos.isEmpty) {
          return _buildEmptyState();
        }

        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400,
            minHeight: 100,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return TodoItem(
                key: ValueKey(todo.id),
                todo: todo,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No todos yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a new todo to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
