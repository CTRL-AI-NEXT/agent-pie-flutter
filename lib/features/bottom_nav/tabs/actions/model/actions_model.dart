
import 'dart:convert';

class ActionsModel {
  final int? id;
  final int? sopId;
  final DateTime? createdAt;
  final List<Step>? steps;

  ActionsModel({
    this.id,
    this.sopId,
    this.createdAt,
    this.steps,
  });

  factory ActionsModel.fromJson(String str) =>
      ActionsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActionsModel.fromMap(Map<String, dynamic> json) => ActionsModel(
        id: json["id"],
        sopId: json["sop_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sop_id": sopId,
        "created_at": createdAt?.toIso8601String(),
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toMap())),
      };
}

class Step {
  final String? title;
  final String? description;
  final List<Substep>? substeps;
  final int? order;
  final int? id;
  final DateTime? createdAt;

  Step({
    this.title,
    this.description,
    this.substeps,
    this.order,
    this.id,
    this.createdAt,
  });

  factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Step.fromMap(Map<String, dynamic> json) => Step(
        title: json["title"],
        description: json["description"],
        substeps: json["substeps"] == null
            ? []
            : List<Substep>.from(
                json["substeps"]!.map((x) => Substep.fromMap(x))),
        order: json["order"],
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "substeps": substeps == null
            ? []
            : List<dynamic>.from(substeps!.map((x) => x.toMap())),
        "order": order,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
      };
}

class Substep {
  final String? text;

  Substep({
    this.text,
  });

  factory Substep.fromJson(String str) => Substep.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Substep.fromMap(Map<String, dynamic> json) => Substep(
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
      };
}
