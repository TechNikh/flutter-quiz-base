// To parse this JSON data, do
//
//     final ftb = ftbFromJson(jsonString);

import 'dart:convert';

List<Fitb> fitbFromJson(String str) => List<Fitb>.from(json.decode(str).map((x) => Fitb.fromJson(x)));

String fitbToJson(List<Fitb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fitb {
  int id;
  String question;
  List<String> answers;
  String solution;
  int timer;

  Fitb({
    required this.id,
    required this.question,
    required this.answers,
    required this.solution,
    required this.timer,
  });

  factory Fitb.empty() => Fitb(
        id: 0,
        question: '',
        answers: [],
        solution: '',
        timer: 0,
      );

  factory Fitb.fromJson(Map<String, dynamic> json) => Fitb(
        id: json["id"],
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
        solution: json["solution"],
        timer: json["timer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "solution": solution,
        "timer": timer,
      };
}
