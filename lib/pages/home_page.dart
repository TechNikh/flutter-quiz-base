import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/pages/quiz_page.dart';
import 'package:quiz_app/widgets/gradient_btn.dart';
import 'package:quiz_app/widgets/my_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showAppbar: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Hello USER!',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              const Text(
                'Stats:',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              GradientBtn(
                  onTap: () => Get.to(() => const QuizPage()),
                  child: const Text(
                    'PLAY QUIZ NOW',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
