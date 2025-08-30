import 'dart:convert';

Quiz quizFromJson(String str) => Quiz.fromJson(json.decode(str));

String quizToJson(Quiz data) => json.encode(data.toJson());

class Quiz {
  final int id;
  final int moduleId;
  final DateTime createdAt;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.moduleId,
    required this.createdAt,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        moduleId: json["module_id"],
        createdAt: DateTime.parse(json["created_at"]),
        questions:
            List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "module_id": moduleId,
        "created_at": createdAt.toIso8601String(),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  final String questionText;
  final String questionType;
  final List<String>? options;
  final String correctAnswer;
  final int id;
  String? userAnswer;

  Question({
    required this.questionText,
    required this.questionType,
    this.options,
    required this.correctAnswer,
    required this.id,
    this.userAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionText: json["question_text"],
        questionType: json["question_type"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        correctAnswer: json["correct_answer"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "question_text": questionText,
        "question_type": questionType,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "correct_answer": correctAnswer,
        "id": id,
      };
}