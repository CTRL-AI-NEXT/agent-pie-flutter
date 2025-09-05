// class ChatMessageResponseModel {
//   final String id;
//   final String message;
//   final String query;
//   final String reference;
//   final DateTime createdAt;
//
//   ChatMessageResponseModel(
//       {required this.id,
//       required this.message,
//       required this.query,
//       required this.reference,
//       required this.createdAt});
// }

class ChatMessageResponseModel {
  final String? question;
  final String? answer;
  final List<int>? sopIds;
  final String? sopTitle;
  final DateTime? createdAt;

  ChatMessageResponseModel({
    this.question,
    this.answer,
    this.sopIds,
    this.sopTitle,
    this.createdAt,
  });

  ChatMessageResponseModel copyWith({
    String? question,
    String? answer,
    List<int>? sopIds,
    final DateTime? createdAt,
    String? sopTitle,
  }) =>
      ChatMessageResponseModel(
        question: question ?? this.question,
        answer: answer ?? this.answer,
        sopIds: sopIds ?? this.sopIds,
        sopTitle: sopTitle ?? this.sopTitle,
      );

  factory ChatMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageResponseModel(
        question: json["question"],
        answer: json["answer"],
        sopIds: json["sop_ids"] == null
            ? []
            : List<int>.from(json["sop_ids"]!.map((x) => x)),
        sopTitle: json["sop_title"],
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "sop_ids":
            sopIds == null ? [] : List<dynamic>.from(sopIds!.map((x) => x)),
        "sop_title": sopTitle,
        "createdAt": sopTitle,
      };
}
