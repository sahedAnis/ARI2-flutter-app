import 'package:flutter/material.dart';
import '../data/models/recipe.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  RecipeListItem({
    required this.recipe,
    required this.onDelete,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(recipe.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: onTap
    );
  }
}
