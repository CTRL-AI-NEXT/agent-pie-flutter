import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/utils/enum.dart';
import 'package:agent_pie/core/widgets/custom_appbar.dart';
import 'package:agent_pie/features/bottom_nav/tabs/quiz/controller/quiz_controller.dart';
import 'package:agent_pie/features/bottom_nav/tabs/quiz/widgets/quiz_question_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (controller) => Scaffold(
        appBar: bottomNavTabAppBar(),
        body: Obx(() {
          if (controller.resultQuizResponse.value.apiResultType ==
              APIResultType.loading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (controller.isQuizCompleted.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🎉', style: TextStyle(fontSize: Dimensions.w50)),
                  SizedBox(height: Dimensions.h20),
                  Text(
                    'Quiz Completed!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: Dimensions.h10),
                  Text(
                    'Well done!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: Dimensions.h30),
                  TextButton(
                    onPressed: controller.resetQuiz,
                    child: const Text('Wanna retest? Take the quiz again!'),
                  )
                ],
              ), // Slightly longer fade duration for a smoother appearance
            ).animate().fade(duration: 800.ms, curve: Curves.easeInOut).scale(
                delay: 200.ms, duration: 600.ms, curve: Curves.elasticOut);
          }

          if (controller.quiz.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.quiz.value!.questions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable manual swipe
                  itemBuilder: (context, index) {
                    return QuizQuestionCard(
                      question: controller.quiz.value!.questions[index],
                      controller: controller,
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
