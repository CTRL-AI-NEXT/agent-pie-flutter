import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/constants/app_colors.dart';
import 'package:agent_pie/features/bottom_nav/tabs/actions/controller/actions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionsTab extends StatelessWidget {
  const ActionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ActionsController controller = Get.put(ActionsController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Cooking Safety: Perfect Pasta',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundColorDark,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.whiteColor),
            onPressed: () => controller.reset(),
          ),
        ],
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Obx(() {
          if (controller.currentStep.value >= controller.recipeSteps.length) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You have completed all the steps!',
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () => controller.reset(),
                    child: Text('Start Over', style: fontStyleMedium14,),
                  ),
                ],
              ),
            );
          }
          return Stack(
            alignment: Alignment.center,
            children: controller.recipeSteps.map((step) {
              final index = controller.recipeSteps.indexOf(step);
              if (index < controller.currentStep.value) {
                return const SizedBox.shrink();
              }
              return Draggable(
                feedback: Material(
                  type: MaterialType.transparency,
                  child: Transform.rotate(
                    angle: 0.1,
                    child: RecipeCard(step: step),
                  ),
                ),
                childWhenDragging: const SizedBox.shrink(),
                onDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dx.abs() > 200) {
                    controller.nextStep();
                  }
                },
                child: RecipeCard(step: step),
              );
            }).toList().reversed.toList(),
          );
        }),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final RecipeStep step;

  const RecipeCard({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shadowColor: AppColors.primaryColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: AppColors.backgroundColorDark,
      child: Container(
        width: Get.width * 0.85,
        height: Get.height * 0.6,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step.stepNumber,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              step.title,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  step.icon,
                  color: AppColors.primaryColor,
                  size: 80.0,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              step.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textGreyColor,
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Swipe to continue',
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}