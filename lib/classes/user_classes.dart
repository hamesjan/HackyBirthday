
import 'dart:convert';

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));

String userIdToJson(UserId data) => json.encode(data.toJson());

class UserId {
  UserId({
    this.mongoresult,
    this.id,
  });

  String mongoresult;
  String id;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    mongoresult: json["mongoresult"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "mongoresult": mongoresult,
    "id": id,
  };
}
