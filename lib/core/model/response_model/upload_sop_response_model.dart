// To parse this JSON data, do
//
//     final uploadSopResponseModel = uploadSopResponseModelFromJson(jsonString);

import 'dart:convert';

UploadSopResponseModel uploadSopResponseModelFromJson(String str) => UploadSopResponseModel.fromJson(json.decode(str));

String uploadSopResponseModelToJson(UploadSopResponseModel data) => json.encode(data.toJson());

class UploadSopResponseModel {
  final String? extractedText;
  final int? id;
  final int? managerId;
  final DateTime? createdAt;

  UploadSopResponseModel({
    this.extractedText,
    this.id,
    this.managerId,
    this.createdAt,
  });

  factory UploadSopResponseModel.fromJson(Map<String, dynamic> json) => UploadSopResponseModel(
    extractedText: json["extracted_text"],
    id: json["id"],
    managerId: json["manager_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "extracted_text": extractedText,
    "id": id,
    "manager_id": managerId,
    "created_at": createdAt?.toIso8601String(),
  };
}
