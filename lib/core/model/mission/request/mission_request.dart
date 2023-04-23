import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';

part 'mission_request.g.dart';

@HiveType(typeId: 0)
class MissionRequest {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  List category;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  final DateTime? createdAt;
  @HiveField(6)
  DateTime? startedAt;
  @HiveField(7)
  DateTime? updatedAt;
  @HiveField(8)
  DateTime? finishedAt;
  @HiveField(9)
  DateTime? archivedAt;
  @HiveField(10)
  int importance;

  MissionRequest(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.date,
      this.createdAt,
      this.updatedAt,
      this.finishedAt,
      this.startedAt,
      this.archivedAt,
      required this.importance});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'date': date,
        'createdAt': createdAt ?? DateTime.now(),
        'updatedAt': updatedAt,
        'finishedAt': finishedAt,
        'startedAt': startedAt,
        'archivedAt': archivedAt,
        'importance': importance
      };

  static MissionRequest fromJson(Map<String, dynamic> json) => MissionRequest(
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        category: json['category'] ?? [],
        importance: json['importance'] ?? 1,
        date: ((json['date'] ?? Timestamp.now()) as Timestamp).toDate(),
        createdAt:
            ((json['createdAt'] ?? Timestamp.now()) as Timestamp).toDate(),
        updatedAt: json['updatedAt'] != null
            ? (json['updatedAt'] as Timestamp).toDate()
            : null,
        finishedAt: json['finishedAt'] != null
            ? (json['finishedAt'] as Timestamp).toDate()
            : null,
        startedAt: json['startedAt'] != null
            ? (json['startedAt'] as Timestamp).toDate()
            : null,
         archivedAt: json['archivedAt'] != null
            ? (json['archivedAt'] as Timestamp).toDate()
            : null,
      );
}
