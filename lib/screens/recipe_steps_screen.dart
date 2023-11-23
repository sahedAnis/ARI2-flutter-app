import 'package:flutter/material.dart';
import '../data/models/recipe.dart';
import '../data/models/recipe_step.dart';

class RecipeStepsScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeStepsScreen({required this.recipe});

  @override
  _RecipeStepsScreenState createState() => _RecipeStepsScreenState();
}

class _RecipeStepsScreenState extends State<RecipeStepsScreen> {
  int currentStepIndex = 0;
  bool completed = false;

  void goToNextStep() {
    setState(() {
      if (currentStepIndex < widget.recipe.steps.length - 1) {
        currentStepIndex++;
      } else {
        completed = true;
      }
    });
  }

  void goToPreviousStep() {
    setState(() {
      if (currentStepIndex > 0) {
        currentStepIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RecipeStep currentStep = widget.recipe.steps[currentStepIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentStep.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentStep.details,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStepIndex == widget.recipe.steps.length - 1)
                  ElevatedButton(
                      onPressed: () {
                        completed = true;
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('Terminer')),
                if ((currentStepIndex != widget.recipe.steps.length - 1) && currentStepIndex > 0)
                  ElevatedButton(
                    onPressed: goToPreviousStep,
                    child: Text('Précédent'),
                  ),
                if ((currentStepIndex != widget.recipe.steps.length - 1) && !completed)
                  ElevatedButton(
                    onPressed: () {
                      goToNextStep();
                    },
                    child: Text('Suivant')
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
