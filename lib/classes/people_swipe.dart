import 'dart:convert';

PeopleList peopleListFromJson(String str) => PeopleList.fromJson(json.decode(str));

String peopleListToJson(PeopleList data) => json.encode(data.toJson());

class PeopleList {
  PeopleList({
    this.ids,
    this.mongoresult,
  });

  List<String> ids;
  String mongoresult;

  factory PeopleList.fromJson(Map<String, dynamic> json) => PeopleList(
    ids: List<String>.from(json["ids"].map((x) => x)),
    mongoresult: json["mongoresult"],
  );

  Map<String, dynamic> toJson() => {
    "ids": List<dynamic>.from(ids.map((x) => x)),
    "mongoresult": mongoresult,
  };
}