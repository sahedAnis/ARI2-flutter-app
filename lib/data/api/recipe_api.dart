import 'dart:convert';

import 'package:demo/data/models/recipe_step.dart';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipeApi {
  final String apiUrl = 'https://655f5a1d879575426b45291e.mockapi.io/api/recipe';

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Recipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch recipe');
    }
  }

  Future<Recipe> createRecipe(String title, String ingredients, List<RecipeStep> steps) async {
    print(steps.length);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'ingredients': ingredients,
        'steps': steps
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to create recipe');
    }
  }

  Future<void> deleteRecipe(String? id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${recipe.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': recipe.title,
        'ingredients': recipe.ingredients,
        'steps': recipe.steps
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update recipe');
    }
  }

  Future<dynamic> getRecipeById(String? id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final dynamic item = json.decode(response.body);
      return Recipe.fromJson(item);
    }
    else if(response.statusCode != 200) {
      throw Exception('Failed to get recipe');
    }
  }
}
