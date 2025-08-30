import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeStep {
  final String stepNumber;
  final String title;
  final String description;
  final IconData icon;

  RecipeStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ActionsController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxList<RecipeStep> recipeSteps = <RecipeStep>[
    RecipeStep(
      stepNumber: 'Step 1',
      title: 'Boil Water',
      description: 'Fill a large pot with plenty of cold water (about 4-6 quarts for 1 pound of pasta). Add a generous amount of salt.',
      icon: Icons.water_drop,
    ),
    RecipeStep(
      stepNumber: 'Step 2',
      title: 'Add Pasta',
      description: 'Once the water is at a rolling boil, add the pasta. Stir gently for the first minute to prevent sticking.',
      icon: Icons.restaurant_menu,
    ),
    RecipeStep(
      stepNumber: 'Step 3',
      title: 'Cook Al Dente',
      description: 'Cook according to package directions, stirring occasionally. Taste a piece to ensure it\'s "al dente" - tender but firm to the bite.',
      icon: Icons.timer,
    ),
    RecipeStep(
      stepNumber: 'Step 4',
      title: 'Save Pasta Water',
      description: 'Before draining, scoop out about a cup of the starchy pasta water. This is liquid gold for your sauce!',
      icon: Icons.opacity,
    ),
    RecipeStep(
      stepNumber: 'Step 5',
      title: 'Drain Pasta',
      description: 'Drain the pasta in a colander. Do not rinse it, as the starch helps the sauce adhere.',
      icon: Icons.local_drink,
    ),
    RecipeStep(
      stepNumber: 'Step 6',
      title: 'Combine with Sauce',
      description: 'Add the drained pasta to your sauce. Use the reserved pasta water to thin the sauce to the perfect consistency.',
      icon: Icons.local_fire_department,
    ),
    RecipeStep(
      stepNumber: 'Step 7',
      title: 'Serve Immediately',
      description: 'Serve hot, garnished with fresh herbs and grated cheese. Buon appetito!',
      icon: Icons.local_dining,
    ),
  ].obs;

  void nextStep() {
    if (currentStep.value < recipeSteps.length) {
      currentStep.value++;
    }
  }

  void reset() {
    currentStep.value = 0;
  }
}