import 'package:demo/data/api/recipe_api.dart';
import 'package:demo/screens/edit_recipe_screen.dart';
import 'package:flutter/material.dart';
import '../data/models/recipe.dart';
import '../widgets/recipe_list_item.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/edit_recipe_screen.dart';

class RecipesListScreen extends StatefulWidget {
  @override
  _RecipesListScreenState createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  List<Recipe> _recipes = [];
  RecipeApi recipeApi = RecipeApi();

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final fetchedRecipes = await recipeApi.fetchRecipes();
    setState(() {
      print(fetchedRecipes.length);
      _recipes = fetchedRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Recettes'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Mes Recettes'),
              onTap: () {
                // Naviguer vers l'écran de la liste des recettes
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Créer une Recette'),
              onTap: () {
                // Naviguer vers l'écran de création de recette
                Navigator.pop(context);
                Navigator.pushNamed(context, '/create');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeListItem(
            recipe: _recipes[index],
            onDelete: () {
              final recipeIndex = index;
              recipeApi.deleteRecipe(_recipes[recipeIndex].id);
              setState(() {
                _recipes.removeAt(recipeIndex);
              });
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(recipe: _recipes[index]),
                ),
              );
            },
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditRecipeScreen(recipeId: _recipes[index].id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
