import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/model/quiz_model.dart';
import 'package:agent_pie/features/bottom_nav/tabs/quiz/controller/quiz_controller.dart';
import 'package:agent_pie/features/bottom_nav/tabs/quiz/widgets/quiz_option_widget.dart';
import 'package:flutter/material.dart';

class QuizQuestionCard extends StatelessWidget {
  final Question question;
  final QuizController controller;

  const QuizQuestionCard(
      {super.key, required this.question, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.w20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: Dimensions.h20),
            if (question.questionType == 'mcq' ||
                question.questionType == 'true_false')
              ...question.options!.map(
                (option) => QuizOptionWidget(
                  optionText: option,
                  isSelected: question.userAnswer == option,
                  onTap: () => controller.selectOption(question.id, option),
                ),
              ),
            if (question.questionType == 'open_ended')
              TextFormField(
                onChanged: (value) {
                  // The answer is saved on change
                  question.userAnswer = value;
                },
                decoration: InputDecoration(
                    hintText: 'Your answer here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.r12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.r12,
                        ),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor))),
                maxLines: 5,
              ),
            SizedBox(height: Dimensions.h10),

            // Save | Submit Button
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final isLastQuestion =
        controller.quiz.value!.questions.last.id == question.id;
    final isOpenEnded = question.questionType == 'open_ended';
    final isAnswered =
        question.userAnswer != null && question.userAnswer!.isNotEmpty;

    bool shouldShowButton = (isLastQuestion && isAnswered) || isOpenEnded;

    if (!shouldShowButton) {
      return const SizedBox.shrink();
    }

    final isSubmit = isLastQuestion;
    final String buttonText = isSubmit ? 'Submit' : 'Save';
    final VoidCallback onPressedAction =
        isSubmit ? controller.completeQuiz : controller.saveAndNext;

    return Center(
      child: MyButton(
        onPressed: onPressedAction,
        miniWidth: Get.width * 0.5,
        title: buttonText,
      ),
    );
  }
}
