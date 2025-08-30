import 'dart:convert';

class ActionsResponse {
  final int id;
  final int sopId;
  final DateTime createdAt;
  final List<Step> steps;

  ActionsResponse({
    required this.id,
    required this.sopId,
    required this.createdAt,
    required this.steps,
  });

  factory ActionsResponse.fromRawJson(String str) =>
      ActionsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionsResponse.fromJson(Map<String, dynamic> json) =>
      ActionsResponse(
        id: json["id"],
        sopId: json["sop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sop_id": sopId,
        "created_at": createdAt.toIso8601String(),
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Step {
  final String title;
  final String description;
  final List<Substep> substeps;
  final int order;
  final int id;
  final DateTime createdAt;

  Step({
    required this.title,
    required this.description,
    required this.substeps,
    required this.order,
    required this.id,
    required this.createdAt,
  });

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        title: json["title"],
        description: json["description"],
        substeps: List<Substep>.from(
            json["substeps"].map((x) => Substep.fromJson(x))),
        order: json["order"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "substeps": List<dynamic>.from(substeps.map((x) => x.toJson())),
        "order": order,
        "id": id,
        "created_at": createdAt.toIso8601String(),
      };
}

class Substep {
  final String text;

  Substep({
    required this.text,
  });

  factory Substep.fromRawJson(String str) => Substep.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Substep.fromJson(Map<String, dynamic> json) => Substep(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}