// To parse this JSON data, do
//
//     final quizResponseModel = quizResponseModelFromJson(jsonString);

import 'dart:convert';

QuizResponseModel quizResponseModelFromJson(String str) => QuizResponseModel.fromJson(json.decode(str));

String quizResponseModelToJson(QuizResponseModel data) => json.encode(data.toJson());

class QuizResponseModel {
  final int? id;
  final int? moduleId;
  final DateTime? createdAt;
  final List<Question>? questions;

  QuizResponseModel({
    this.id,
    this.moduleId,
    this.createdAt,
    this.questions,
  });

  factory QuizResponseModel.fromJson(Map<String, dynamic> json) => QuizResponseModel(
    id: json["id"],
    moduleId: json["module_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "module_id": moduleId,
    "created_at": createdAt?.toIso8601String(),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  final String? questionText;
  final String? questionType;
  final List<String>? options;
  final String? correctAnswer;
  final int? id;

  Question({
    this.questionText,
    this.questionType,
    this.options,
    this.correctAnswer,
    this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionText: json["question_text"],
    questionType: json["question_type"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    correctAnswer: json["correct_answer"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "question_text": questionText,
    "question_type": questionType,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "correct_answer": correctAnswer,
    "id": id,
  };
}
