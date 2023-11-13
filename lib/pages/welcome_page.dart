import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/widgets/gradient_btn.dart';
import 'package:quiz_app/widgets/my_scaffold.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz App',
            style: TextStyle(color: Colors.white, fontSize: 80),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(borderRadius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30),
                  ),
                  GradientBtn(
                    onTap: () => Get.offAll(() => const HomePage()),
                    width: 250,
                    child: const Text(
                      'Let\'s Quiz!',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
