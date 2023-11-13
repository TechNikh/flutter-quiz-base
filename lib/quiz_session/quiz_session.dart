import 'package:flutter/foundation.dart';

class QuizSession {
  List<Map<String, dynamic>> questions = [];

  int score = 0;
  List<List<dynamic>> selectedAnswers = [];

  calculateScore() {
    double correctAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      if (questions[i]['type'] == 'mcq') {
        selectedAnswers[i].sort();
        questions[i]['answer_index'].sort();

        if (listEquals(selectedAnswers[i], questions[i]['answer_index'])) {
          correctAnswers++;
        }
      } else {
        for (int j = 0; j < selectedAnswers[i].length; j++) {
          final selectedAnswer = selectedAnswers[i][j];
          if (selectedAnswer == questions[i]['answers'][j].toString().toLowerCase()) {
            correctAnswers = correctAnswers + (1 / questions[i]['answers'].length);
          }
        }
      }
    }

    score = correctAnswers * 100 ~/ questions.length;
  }
}
