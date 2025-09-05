// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  int? id;
  String? name;
  String? email;
  bool? isManager;
  List<Sop>? sops;

  LoginResponseModel({
    this.id,
    this.name,
    this.email,
    this.isManager,
    this.sops,
  });

  LoginResponseModel copyWith({
    int? id,
    String? name,
    String? email,
    bool? isManager,
    List<Sop>? sops,
  }) =>
      LoginResponseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        isManager: isManager ?? this.isManager,
        sops: sops ?? this.sops,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    isManager: json["is_manager"],
    sops: json["sops"] == null ? [] : List<Sop>.from(json["sops"]!.map((x) => Sop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "is_manager": isManager,
    "sops": sops == null ? [] : List<dynamic>.from(sops!.map((x) => x.toJson())),
  };
}

class Sop {
  int? id;
  String? filename;
  DateTime? createdAt;

  Sop({
    this.id,
    this.filename,
    this.createdAt,
  });

  Sop copyWith({
    int? id,
    String? filename,
    DateTime? createdAt,
  }) =>
      Sop(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Sop.fromJson(Map<String, dynamic> json) => Sop(
    id: json["id"],
    filename: json["filename"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "created_at": createdAt?.toIso8601String(),
  };
}
