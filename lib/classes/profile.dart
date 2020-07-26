// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.username,
    this.age,
    this.gender,
    this.major,
    this.school,
    this.year,
    this.backend,
    this.frontend,
    this.fullstack,
    this.hardware,
    this.mobile,
    this.react,
    this.javascript,
    this.python,
    this.angular,
    this.java,
    this.c,
    this.profileC,
    this.gcp,
    this.aws,
    this.mongodb,
    this.firebase,
    this.tagline,
  });

  String username;
  String age;
  String gender;
  String major;
  String school;
  String year;
  bool backend;
  bool frontend;
  bool fullstack;
  bool hardware;
  bool mobile;
  bool react;
  bool javascript;
  bool python;
  bool angular;
  bool java;
  bool c;
  bool profileC;
  bool gcp;
  bool aws;
  bool mongodb;
  bool firebase;
  String tagline;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    username: json["username"],
    age: json["age"],
    gender: json["gender"],
    major: json["major"],
    school: json["school"],
    year: json["year"],
    backend: json["backend"],
    frontend: json["frontend"],
    fullstack: json["fullstack"],
    hardware: json["hardware"],
    mobile: json["mobile"],
    react: json["react"],
    javascript: json["javascript"],
    python: json["python"],
    angular: json["angular"],
    java: json["java"],
    c: json["c"],
    profileC: json["c++"],
    gcp: json["gcp"],
    aws: json["aws"],
    mongodb: json["mongodb"],
    firebase: json["firebase"],
    tagline: json["tagline"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "age": age,
    "gender": gender,
    "major": major,
    "school": school,
    "year": year,
    "backend": backend,
    "frontend": frontend,
    "fullstack": fullstack,
    "hardware": hardware,
    "mobile": mobile,
    "react": react,
    "javascript": javascript,
    "python": python,
    "angular": angular,
    "java": java,
    "c": c,
    "c++": profileC,
    "gcp": gcp,
    "aws": aws,
    "mongodb": mongodb,
    "firebase": firebase,
    "tagline": tagline,
  };
}
