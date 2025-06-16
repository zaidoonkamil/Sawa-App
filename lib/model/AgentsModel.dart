import 'dart:convert';

List<AgentsModel> agentsModelFromJson(String str) => List<AgentsModel>.from(json.decode(str).map((x) => AgentsModel.fromJson(x)));

String agentsModelToJson(List<AgentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgentsModel {
  int id;
  String name;
  String phone;
  String location;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  AgentsModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgentsModel.fromJson(Map<String, dynamic> json) => AgentsModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "location": location,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
