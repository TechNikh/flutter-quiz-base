// To parse this JSON data, do
//
//     final mcq = mcqFromJson(jsonString);

import 'dart:convert';

List<Mcq> mcqsFromJson(String str) => List<Mcq>.from(json.decode(str).map((x) => Mcq.fromJson(x)));

String mcqsToJson(List<Mcq> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mcq {
  int id;
  String question;
  List<String> options;
  List<int> answerIndex;
  String solution;
  int timer;

  Mcq({
    required this.id,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.solution,
    required this.timer,
  });

  factory Mcq.empty() => Mcq(
        id: 0,
        question: '',
        options: [],
        answerIndex: [],
        solution: '',
        timer: 0,
      );

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        id: json["id"],
        question: json["question"],
        options: List<String>.from(json["options"].map((x) => x)),
        answerIndex: List<int>.from(json["answer_index"].map((x) => x)),
        solution: json["solution"],
        timer: json["timer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x)),
        "answer_index": List<dynamic>.from(answerIndex.map((x) => x)),
        "solution": solution,
        "timer": timer,
      };
}

final mcqSamples = [
  {
    "type": "mcq",
    "id": 1,
    "question": "Who developed the Flutter Framework and continues to maintain it today?",
    "options": ["Facebook", "Google", "Microsoft", "Oracle"],
    "answer_index": [1],
    "solution":
        "Google began developing Flutter back in 2015 and supports its continued development and maintenance today alongside a highly active open-source community.",
    "timer": 20,
  },
  {
    "type": "fitb",
    "id": 2,
    "question": "#fitb is the programming language used to build Flutter applications",
    "answers": ["Dart"],
    "solution": "Flutter programs are written in Google's own Dart programming language.",
    "timer": 30,
  },
  {
    "type": "mcq",
    "id": 3,
    "question": "How many types of widgets are there in Flutter?",
    "options": ["2", "5", "3", "1"],
    "answer_index": [0],
    "solution":
        "There are two types of widgets available to developers in Flutter. These are stateful and stateless widgets.",
    "timer": 30,
  },
  {
    "type": "mcq",
    "id": 4,
    "question": "A sequence of asynchronous Flutter events is known as a Series",
    "options": ['true', 'false'],
    "answer_index": [1],
    "solution": "A sequence of asynchronous events is often referred to as a stream.",
    "timer": 20,
  },
  {
    "type": "mcq",
    "id": 5,
    "question": "What are some key advantages of Flutter over alternate frameworks?",
    "options": [
      "Rapid cross-platform application development and debugging tools",
      "Future-proofed technologies and UI resources",
      "Strong supporting tools for application development and launch",
      "None of the above"
    ],
    "answer_index": [0, 1, 2],
    "solution":
        "Flutter boasts all of these features for developers as improvements over competing frameworks or native application development.",
    "timer": 30,
  },
];
