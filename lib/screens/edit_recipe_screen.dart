import 'package:flutter/material.dart';
import '../data/models/recipe.dart';
import '../data/api/recipe_api.dart';
import '../data/models/recipe_step.dart';
class EditRecipeScreen extends StatefulWidget {
  final String? recipeId;

  EditRecipeScreen({this.recipeId});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  final RecipeApi recipeApi = RecipeApi();
  late Recipe _fetchedRecipe = Recipe(ingredients: '', steps: [], title: '');
  List<RecipeStep> _updatedsteps = [];

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    final fetchedRecipe = await recipeApi.getRecipeById(widget.recipeId);
    setState(() {
      _fetchedRecipe = fetchedRecipe;
      _updatedsteps = _fetchedRecipe.steps;
    });
  }

  void _addStep() {
    setState(() {
      _updatedsteps.add(RecipeStep(name: '', details: '')); // Ajouter une nouvelle étape à la liste
    });
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = _fetchedRecipe.title ?? ''; // Set the initial value using the controller
    _ingredientsController.text = _fetchedRecipe.ingredients ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la recette'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titre de la recette')
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingrédients'),
              maxLines: null
            ),
            ElevatedButton(
              onPressed: _addStep,
              child: Text('Ajouter une étape'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _updatedsteps.length,
              itemBuilder: (context, index) {
                TextEditingController nameController = TextEditingController(text: _fetchedRecipe.steps[index].name);
                TextEditingController detailsController = TextEditingController(text: _fetchedRecipe.steps[index].details);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nom de l\'étape'),
                      onChanged: (value) {
                        setState(() {
                          _updatedsteps[index].name = value; // Mettre à jour le nom de l'étape
                        });
                      },
                    ),
                    TextFormField(
                      controller: detailsController,
                      decoration: InputDecoration(labelText: 'Détails de l\'étape'),
                      onChanged: (value) {
                        setState(() {
                          _updatedsteps[index].details = value; // Mettre à jour les détails de l'étape
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
                Recipe updatedRecipe = Recipe(
                  id: _fetchedRecipe.id,
                  title: _titleController.text,
                  ingredients: _ingredientsController.text,
                  steps: _updatedsteps,
                );
                await recipeApi.updateRecipe(updatedRecipe);

                Navigator.pushNamed(context, '/');
              },
              child: Text('Modifier la recette'),
            ),
          ],
        ),
      ),
    );
  }
}
