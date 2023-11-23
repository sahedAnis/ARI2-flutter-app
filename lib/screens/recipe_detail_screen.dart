import 'package:flutter/material.dart';
import '../data/models/recipe.dart';
import '../screens/recipe_steps_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Afficher la liste des ingrédients
          ListTile(
            title: Text('Ingrédients:'),
            subtitle: Text(recipe.ingredients),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeStepsScreen(recipe: recipe),
                ),
              );
            },
            child: Text('Démarrer'),
          ),
        ],
      ),
    );
  }
}
