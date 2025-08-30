// To parse this JSON data, do
//
//     final trainingResponseModel = trainingResponseModelFromJson(jsonString);

import 'dart:convert';

TrainingResponseModel trainingResponseModelFromJson(String str) => TrainingResponseModel.fromJson(json.decode(str));

String trainingResponseModelToJson(TrainingResponseModel data) => json.encode(data.toJson());

class TrainingResponseModel {
  int? id;
  int? sopId;
  DateTime? createdAt;
  List<Step>? steps;

  TrainingResponseModel({
    this.id,
    this.sopId,
    this.createdAt,
    this.steps,
  });

  TrainingResponseModel copyWith({
    int? id,
    int? sopId,
    DateTime? createdAt,
    List<Step>? steps,
  }) =>
      TrainingResponseModel(
        id: id ?? this.id,
        sopId: sopId ?? this.sopId,
        createdAt: createdAt ?? this.createdAt,
        steps: steps ?? this.steps,
      );

  factory TrainingResponseModel.fromJson(Map<String, dynamic> json) => TrainingResponseModel(
    id: json["id"],
    sopId: json["sop_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    steps: json["steps"] == null ? [] : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sop_id": sopId,
    "created_at": createdAt?.toIso8601String(),
    "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
  };
}

class Step {
  String? title;
  String? description;
  List<Substep>? substeps;
  int? order;
  int? id;
  DateTime? createdAt;

  Step({
    this.title,
    this.description,
    this.substeps,
    this.order,
    this.id,
    this.createdAt,
  });

  Step copyWith({
    String? title,
    String? description,
    List<Substep>? substeps,
    int? order,
    int? id,
    DateTime? createdAt,
  }) =>
      Step(
        title: title ?? this.title,
        description: description ?? this.description,
        substeps: substeps ?? this.substeps,
        order: order ?? this.order,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    title: json["title"],
    description: json["description"],
    substeps: json["substeps"] == null ? [] : List<Substep>.from(json["substeps"]!.map((x) => Substep.fromJson(x))),
    order: json["order"],
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "substeps": substeps == null ? [] : List<dynamic>.from(substeps!.map((x) => x.toJson())),
    "order": order,
    "id": id,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Substep {
  String? text;

  Substep({
    this.text,
  });

  Substep copyWith({
    String? text,
  }) =>
      Substep(
        text: text ?? this.text,
      );

  factory Substep.fromJson(Map<String, dynamic> json) => Substep(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}
