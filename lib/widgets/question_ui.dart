import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/data/objects/fitb.dart';
import 'package:quiz_app/data/objects/mcq.dart';
import 'package:quiz_app/quiz_session/quiz_session.dart';

class QuestionUI extends StatefulWidget {
  const QuestionUI(
      {super.key,
      required this.isFlashcardMode,
      required this.quizSession,
      required this.index,
      required this.pageC});

  final QuizSession quizSession;
  final int index;
  final PageController pageC;
  final bool isFlashcardMode;

  @override
  State<QuestionUI> createState() => _QuestionUIState();
}

class _QuestionUIState extends State<QuestionUI> {
  late Object question;
  Mcq mcq = Mcq.empty();
  Fitb fitb = Fitb.empty();

  String fitbQuestion = '';

  List<TextEditingController> fitbBlankCs = [];

  FlipCardController _flipCardController = FlipCardController();

  initData() {
    if (widget.quizSession.questions[widget.index]['type'] == 'mcq') {
      question = Mcq.empty();
      mcq = Mcq.fromJson(widget.quizSession.questions[widget.index]);
    } else {
      question = Fitb.empty();
      fitb = Fitb.fromJson(widget.quizSession.questions[widget.index]);
    }

    if (question is Fitb) {
      int noOfBlanks = 0;

      for (int i = 0; i < fitb.question.split(' ').length; i++) {
        final fitbWord = fitb.question.split(' ')[i];
        // widget.quizSession.selectedAnswers[widget.index].add('');

        if (fitbWord == '#fitb') {
          noOfBlanks++;
          fitbQuestion = '${fitbQuestion}___($noOfBlanks)___ ';

          if (widget.quizSession.selectedAnswers[widget.index].length <
              noOfBlanks) {
            widget.quizSession.selectedAnswers[widget.index].add('');
          }

          fitbBlankCs.add(TextEditingController(
              text: widget.quizSession.selectedAnswers[widget.index]
                  [noOfBlanks - 1]));
        } else {
          fitbQuestion = '$fitbQuestion$fitbWord ';
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: _flipCardController,
      flipOnTouch: false,
      front: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${widget.index + 1}.',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    question is Mcq ? mcq.question : fitbQuestion,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: question is Mcq
                        ? mcq.options.length
                        : fitbBlankCs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () => question is Mcq
                              ? setState(() {
                                  if (!widget
                                      .quizSession.selectedAnswers[widget.index]
                                      .contains(index)) {
                                    if (mcq.answerIndex.length == 1) {
                                      widget.quizSession
                                          .selectedAnswers[widget.index]
                                          .clear();
                                    }
                                    widget.quizSession
                                        .selectedAnswers[widget.index]
                                        .add(index);
                                  } else {
                                    if (mcq.answerIndex.length == 1) {
                                      widget.quizSession
                                          .selectedAnswers[widget.index]
                                          .clear();
                                    } else {
                                      widget.quizSession
                                          .selectedAnswers[widget.index]
                                          .remove(index);
                                    }
                                  }
                                })
                              : null,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                color: widget.quizSession
                                        .selectedAnswers[widget.index]
                                        .contains(index)
                                    ? const Color.fromARGB(255, 125, 40, 255)
                                    : null),
                            child: question is Mcq
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            mcq.options.elementAt(index),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: widget
                                                        .quizSession
                                                        .selectedAnswers[
                                                            widget.index]
                                                        .contains(index)
                                                    ? Colors.white
                                                    : null),
                                          ),
                                        ),
                                        if (mcq.answerIndex.length != 1)
                                          widget.quizSession
                                                  .selectedAnswers[widget.index]
                                                  .contains(index)
                                              ? const Icon(Icons.check_box,
                                                  color: Colors.white)
                                              : const Icon(
                                                  Icons.check_box_outline_blank)
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(${index + 1}) ',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: fitbBlankCs[index],
                                            style:
                                                const TextStyle(fontSize: 20),
                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            onChanged: (value) {
                                              if (widget
                                                      .quizSession
                                                      .selectedAnswers[
                                                          widget.index]
                                                      .length >=
                                                  index + 1) {
                                                widget.quizSession
                                                            .selectedAnswers[
                                                        widget.index][index] =
                                                    value.toLowerCase();
                                              } else {
                                                widget
                                                    .quizSession
                                                    .selectedAnswers[
                                                        widget.index]
                                                    .add(value.toLowerCase());
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if(widget.isFlashcardMode)
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async{
                        await _flipCardController.toggleCard();
                      },
                      icon: const Icon(Icons.autorenew),
                      label: const Text('Turn'),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 125, 40, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  )),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  '<< SWIPE >>',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          if (widget.index != 0)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: IconButton(
                    onPressed: () {
                      widget.pageC.previousPage(
                          duration: const Duration(milliseconds: 650),
                          curve: Curves.linearToEaseOut);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
            ),
          if (widget.index + 1 != widget.quizSession.questions.length)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: IconButton(
                    onPressed: () {
                      widget.pageC.nextPage(
                          duration: const Duration(milliseconds: 650),
                          curve: Curves.linearToEaseOut);
                    },
                    icon: const Icon(Icons.arrow_forward)),
              ),
            ),
        ],
      ),
      fill: Fill.fillBack,
      back: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Solution :', style: TextStyle(fontWeight: FontWeight.w900),),
            Text(widget.quizSession.questions[widget.index]['solution']
                .toString()),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async{
                  await _flipCardController.toggleCard();
                },
                icon: const Icon(Icons.autorenew),
                label: const Text('Turn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
