import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/ui/widgets/questions_summary.dart';
import 'package:quiz_app/ui/widgets/quiz_button.dart';
import 'package:quiz_app/ui/widgets/styled_text.dart';

// Requirements: 
// User should see how many questions (# out of #) they answered correctly
// Each asked question should be displayed in a numbered list
// Each asked question should show the chosen answer and correct answer below it
// UI/UX should show clear indicators if the question was answered correctly or wrong
// Chosen answer and correct answer should have different font colors to distinguish them
// The asked questions and shown answers should be in a scrollable container 
// A restart quiz button should be available and stickied to the bottom-center of the screen


class ResultsScreen extends StatelessWidget{
  const ResultsScreen({super.key, required this.chosenAnswers, required this.activeQuestions, required this.onRestart});

  final List<String> chosenAnswers;
  final List<QuizQuestion> activeQuestions;
  final VoidCallback onRestart;

  // Maps the answers to their respective question objects and scores the quiz
  List<Map<String, Object>> evaluateQuiz() {
    final List<Map<String, Object>> summary = [];

    // I need to access the index here for the questions/answers, which requires a for loop and not a for..in
   for (var i = 0; i < chosenAnswers.length; i++) {
    summary.add({
      'questions_index': i,
      'question_text': activeQuestions[i].text,
      'correct_answer': activeQuestions[i].answers[0],
      'chosen_answer': chosenAnswers[i],
    });
   }
   return summary;

  }

  @override
  Widget build(BuildContext context) {

    final summaryData = evaluateQuiz();
    final totalQuestions = activeQuestions.length;

    // checks how many chosen answers correspond to the correct answers (like a filter)
    final correctQuestions = summaryData.where((data) {
      return data['chosen_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity, // use as much width as possible
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText("You answered $correctQuestions out of $totalQuestions questions correctly!" , 24),
            const SizedBox(height: 30),
            Expanded(
              child: QuestionsSummary(summaryData: summaryData),
            ),
            const SizedBox(height: 30),
            QuizButton(buttonText: "Restart Quiz", onPressed: onRestart, backgroundColor: const Color.fromARGB(255, 54, 10, 105), isRefreshButton: true,),

        
        ]),
      ),
    );
  }
}