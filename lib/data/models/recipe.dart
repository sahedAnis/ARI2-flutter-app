import './recipe_step.dart';

class Recipe {
  String? id;
  String title;
  String ingredients;
  List<RecipeStep> steps;

  Recipe({
    this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var list = json['steps'] as List;
    List<RecipeStep> stepList = list.map((step) => RecipeStep.fromJson(step)).toList();
    return Recipe(
      id: json['id'],
      title: json['title'],
      ingredients: json['ingredients'],
      steps: stepList,
    );
  }
}
