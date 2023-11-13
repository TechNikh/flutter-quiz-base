import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/quiz_session/quiz_session.dart';
import 'package:quiz_app/widgets/my_scaffold.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key, required this.quizSession});
  final QuizSession quizSession;

  @override
  Widget build(BuildContext context) {
    quizSession.calculateScore();
    return MyScaffold(
      showAppbar: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              color: Colors.white,
              boxShadow: const [BoxShadow(offset: Offset(0, 2), blurRadius: 5)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quizSession.score.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const Divider(thickness: 2),
                const Text(
                  '100',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: const [BoxShadow(offset: Offset(0, 2), blurRadius: 5)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: TextButton(onPressed: () => {}, child: const Text('View Solutions')),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () => Get.offAll(() => const HomePage()), child: const Text('Home')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
