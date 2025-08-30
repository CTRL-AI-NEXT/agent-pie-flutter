import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/model/quiz_model.dart';
import 'package:flutter/material.dart';

class QuizController extends GetxController {
  final pageController = PageController();
  final RxInt currentPage = 0.obs;
  final Rx<Quiz?> quiz = Rx<Quiz?>(null);
  final RxBool quizSubmitted = false.obs;
  final RxBool isQuizCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  void loadQuestions() {
    const mockResponse = '''
    {
      "id": 1,
      "module_id": 9,
      "created_at": "2025-08-30T18:47:30.969617+05:30",
      "questions": [
        {
          "question_text": "Which step comes immediately after forming and seasoning the patty?",
          "question_type": "mcq",
          "options": [
            "Grill the patty to doneness",
            "Toast and sauce the bun",
            "Preheat and ready the grill",
            "Assemble and serve the burger"
          ],
          "correct_answer": "Grill the patty to doneness",
          "id": 1
        },
        {
          "question_text": "What is the main goal of preheating and readying the grill?",
          "question_type": "mcq",
          "options": [
            "Ensure the cooking surface is at the correct temperature for searing and safe cooking",
            "Keep the bun from getting soggy",
            "Balance seasoning flavors in the patty",
            "Melt the cheese evenly"
          ],
          "correct_answer": "Ensure the cooking surface is at the correct temperature for searing and safe cooking",
          "id": 2
        },
        {
          "question_text": "For best flavor distribution and texture, sauces should be applied to:",
          "question_type": "mcq",
          "options": [
            "Both sides of the bun",
            "Only the top bun",
            "Only the bottom bun",
            "Neither bun"
          ],
          "correct_answer": "Both sides of the bun",
          "id": 3
        },
             {
          "question_text": "List the full sequence of steps, in order, to prepare and serve the cheeseburger as described.",
          "question_type": "open_ended",
          "options": null,
          "correct_answer": "1) Gather and prepare materials; 2) Preheat and ready the grill; 3) Form and season the patty; 4) Grill the patty to doneness; 5) Melt the cheese; 6) Toast and sauce the bun; 7) Assemble and serve the burger.",
          "id": 4
        },
        {
          "question_text": "True or False: The cheese is melted before the patty is grilled to doneness.",
          "question_type": "true_false",
          "options": [
            "True",
            "False"
          ],
          "correct_answer": "False",
          "id": 5
        }
   
      ]
    }
    ''';
    quiz.value = quizFromJson(mockResponse);
  }

  void selectOption(int questionId, String option) {
    final questionIndex = quiz.value?.questions.indexWhere((q) => q.id == questionId);
    if (questionIndex == null) return;

    final question = quiz.value!.questions[questionIndex];
    if (question.userAnswer != null) return; // Already answered

    question.userAnswer = option;
    quiz.refresh();

    // Auto-advance if not an open-ended question and not the last question
    if (question.questionType != 'open_ended' && questionIndex < quiz.value!.questions.length - 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void saveAndNext() {
    if (currentPage.value < quiz.value!.questions.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void completeQuiz() {
    isQuizCompleted.value = true;
    submitQuiz();
  }

  void submitQuiz() {
    quizSubmitted.value = true;
    // Mock API call
    print('Submitting quiz data:');
    if (quiz.value != null) {
      print(quizToJson(quiz.value!));
    }
  }

  void resetQuiz() {
    // Reset answers
    for (var question in quiz.value!.questions) {
      question.userAnswer = null;
    }

    // Reset state variables
    isQuizCompleted.value = false;
    quizSubmitted.value = false;
    currentPage.value = 0;

    // Go back to the first page
    pageController.jumpToPage(0);

    quiz.refresh();
  }
}
