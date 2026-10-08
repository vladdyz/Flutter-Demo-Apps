//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/ui/widgets/quiz_button.dart';
import 'package:quiz_app/ui/widgets/styled_text.dart';
import 'package:quiz_app/models/quiz_question.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.activeQuestions,
    required this.onSelectAnswer,
  });

  final List<QuizQuestion> activeQuestions;
  final void Function(String answer) onSelectAnswer;
  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  // Make sure that the answer selected by the user is passed to the topmost layer (quiz.dart) which manages state
  // OnPressed (user clicks answer button and the answer text is grabbed)
  //  -> answerQuestion (passes on the answer and checks if more questions are available to cycle to)
  //    -> onSelectAnswer (answer used as value and lifted up to quiz.dart)
  //      -> chooseAnswer(in quiz.dart, where the answer is added to the list of selected answers)
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    // Only advance to the next question if there are questions (extra safety to prevent out of bounds)
    if (currentQuestionIndex < widget.activeQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final random = Random();
    // The quiz now randomly selects 5 shuffled questions, no need to randomize again
    //final currentQuestion = questions[random.nextInt(questions.length)];
    final currentQuestion = widget.activeQuestions[currentQuestionIndex];

    // Alternatively could use Center as a wrapper here
    return SizedBox(
      width: double.infinity, // use as much width as possible
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const Text("The question..."),
            Center(child: StyledText(currentQuestion.text, 24)),
            const SizedBox(height: 30),
            //ElevatedButton(onPressed:() {}, child: Text("Answer 1"),),
            for (String answer in currentQuestion.shuffledAnswers) ...[
              QuizButton(
                buttonText: answer,
                onPressed: () => answerQuestion(answer),
                backgroundColor: const Color.fromARGB(255, 54, 10, 105),
                isAnswerButton: true,
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
