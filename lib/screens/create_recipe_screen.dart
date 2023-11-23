import 'package:flutter/material.dart';
import '../data/models/recipe.dart';
import '../data/api/recipe_api.dart';
import '../data/models/recipe_step.dart';
class CreateRecipeScreen extends StatefulWidget {
  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  final RecipeApi recipeApi = RecipeApi();
  List<RecipeStep> _steps = [];

  void _addStep() {
    setState(() {
      _steps.add(RecipeStep(name: '', details: '')); // Ajouter une nouvelle étape à la liste
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une Recette'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titre de la recette'),
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingrédients'),
              maxLines: null,
            ),
            ElevatedButton(
              onPressed: _addStep,
              child: Text('Ajouter une étape'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nom de l\'étape'),
                      onChanged: (value) {
                        setState(() {
                          _steps[index].name = value; // Mettre à jour le nom de l'étape
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Détails de l\'étape'),
                      onChanged: (value) {
                        setState(() {
                          _steps[index].details = value; // Mettre à jour les détails de l'étape
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Recipe newRecipe = Recipe(
                  title: _titleController.text,
                  ingredients: _ingredientsController.text,
                  steps: _steps,
                );
                await recipeApi.createRecipe(newRecipe.title, newRecipe.ingredients, newRecipe.steps);

                Navigator.pushNamed(context, '/');
              },
              child: Text('Ajouter Recette'),
            ),
          ],
        ),
      ),
    );
  }
}
