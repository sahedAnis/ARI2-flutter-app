import 'package:demo/screens/recipe_steps_screen.dart';
import 'package:flutter/material.dart';
import '../screens/recipes_list_screen.dart';
import '../screens/create_recipe_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/recipe_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Recettes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RecipesListScreen(),
        '/create': (context) => CreateRecipeScreen(),
      },
    );
  }
}