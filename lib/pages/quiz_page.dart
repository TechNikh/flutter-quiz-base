import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/data/apis/questions_api.dart';
import 'package:quiz_app/pages/score_page.dart';
import 'package:quiz_app/quiz_session/quiz_session.dart';
import 'package:quiz_app/widgets/my_scaffold.dart';
import 'package:quiz_app/widgets/question_ui.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, bool showSolutions = false});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final quizSession = QuizSession();

  bool isFetching = true;
  final pageC = PageController();

  fetchMcqs() async {
    quizSession.questions = await QuestionsApiService().fetchQuestions();
    for (int i = 0; i < quizSession.questions.length; i++) {
      quizSession.selectedAnswers.add([]);
    }
    setState(() => isFetching = false);
  }

  @override
  void initState() {
    fetchMcqs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    confirmExit() {
      Get.defaultDialog(title: 'End test', content: const Text('Do you want to end the test?'), actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Yes')),
      ]);
    }

    return WillPopScope(
      onWillPop: () async {
        confirmExit();

        return false;
      },
      child: MyScaffold(
        child: isFetching
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => confirmExit(),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (quizSession.selectedAnswers.every((element) => element.isNotEmpty)) {
                              Get.off(() => ScorePage(quizSession: quizSession));
                            } else {
                              Get.defaultDialog(
                                  content:
                                      const Text('You have not answered all questions.\nDo you want to end the test?'),
                                  actions: [
                                    TextButton(onPressed: () => Get.back(), child: const Text('No')),
                                    ElevatedButton(
                                      onPressed: () => Get.off(() => ScorePage(quizSession: quizSession)),
                                      child: const Text('Yes'),
                                    ),
                                  ]);
                            }
                          },
                          child: const Text('SUBMIT'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50.0 * quizSession.questions.length,
                    child: _PageIndexBuilder(quizSession: quizSession, pageC: pageC),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: pageC,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) => SystemChannels.textInput.invokeMethod('TextInput.hide'),
                      itemCount: quizSession.questions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(borderRadius),
                                  boxShadow: const [BoxShadow(offset: Offset(0, 2), blurRadius: 5)],
                                ),
                                child: QuestionUI(quizSession: quizSession, index: index, pageC: pageC),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class _PageIndexBuilder extends StatefulWidget {
  const _PageIndexBuilder({required this.quizSession, required this.pageC});
  final QuizSession quizSession;
  final PageController pageC;

  @override
  State<_PageIndexBuilder> createState() => _PageIndexBuilderState();
}

class _PageIndexBuilderState extends State<_PageIndexBuilder> {
  @override
  Widget build(BuildContext context) {
    widget.pageC.addListener(() => setState(() {}));

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.quizSession.questions.length,
      itemBuilder: (context, index) {
        bool isQuestionAttempted = false;
        if (widget.quizSession.selectedAnswers[index].isNotEmpty) {
          isQuestionAttempted = true;
        }

        if (widget.quizSession.questions[index]['type'] == 'fitb') {
          bool isAnyOneAttempted = false;
          for (final selectedAnswer in widget.quizSession.selectedAnswers[index]) {
            if (selectedAnswer is String) {
              if (selectedAnswer != '') {
                isAnyOneAttempted = true;
              }
            }
            if (isAnyOneAttempted) {
              isQuestionAttempted = true;
            } else {
              isQuestionAttempted = false;
            }
          }
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: InkWell(
            onTap: () => widget.pageC
                .animateToPage(index, duration: const Duration(milliseconds: 650), curve: Curves.linearToEaseOut),
            child: CircleAvatar(
              backgroundColor: (widget.pageC.page ?? 0).toInt() == index ? Colors.amber : null,
              child: isQuestionAttempted ? const Icon(Icons.done_all) : Text('${index + 1}'),
            ),
          ),
        );
      },
    );
  }
}
