import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/ui/screens/home_screen.dart';
import 'package:quiz_app/ui/screens/questions_screen.dart';
import 'package:quiz_app/ui/screens/results_screen.dart';

// Sets the amount of questions randomly chosen for a quiz instance
const int amountOfQuestions = 5;


// Nests the various screens inside of consistent box decoration styling
// Wraps all of the screens in the Scaffold
// Most importantly, needs to manage the state used by the other screens (which screen should be shown)
// the state is lifted up from the screen classes to here, and renders screen content conditionally
class Quiz extends StatefulWidget {
  const Quiz(this.startColor, this.endColor, {super.key});
  final Color? startColor;
  final Color? endColor;

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {

  // Instead of storing the screen as a variable, refactored to take a more lightweight approach
  // Now store an identifier variable to tell us what screen should be used in build
  String activeScreen = 'home-screen';

  // // Assign a widget to a variable, specify of type "Widget"
  // // Otherwise it will assume a more specific type of the widget class (e.g. <HomeScreen> etc)
  // Widget? activeScreen;


  // Lifted up from questions_screen.dart now that quiz results is a separate screen
  late List<QuizQuestion> activeQuestions;
  final List<String> chosenAnswers = []; // The list itself is final but elements can be added in dynamically


  // executes when this object is first initialized and prepares the list of questions
  @override
  void initState() {
    super.initState();
    _resetQuizData();
  } 

  // Initializes and resets the questions list by randomly selecting questions from the data
  void _resetQuizData() {
    chosenAnswers.clear();
    activeQuestions = (List.of(questions)..shuffle()).take(amountOfQuestions).toList();
  }
  void switchScreen() {
    setState(() {
      _resetQuizData(); // restarting the quiz generates a fresh list of questions
      //activeScreen = QuestionsScreen();
      activeScreen = 'questions-screen';
    });
  }

  // Lifted callback from quiz_questions so that it can be passed to the answers screen
  void chooseAnswer(String answer) {
    chosenAnswers.add(answer);

    // If we have answered all the chosen questions, go to results
    if (chosenAnswers.length == activeQuestions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  } 

 @override
  Widget build(BuildContext context) {
    // both must be prefixed by widget property which references the Quiz widget config
    final homeColorStart = widget.startColor ?? Colors.indigo;
    final homeColorEnd = widget.endColor ?? Colors.deepPurple;

    // Dynamically determine the screen based on the identifier variables
    Widget screenWidget = switch(activeScreen) {
      'questions-screen' => QuestionsScreen(
        activeQuestions: activeQuestions,
        onSelectAnswer: chooseAnswer,
      ),
      'home-screen' => HomeScreen(homeColorStart, switchScreen),
      'results-screen' => ResultsScreen(chosenAnswers: chosenAnswers, activeQuestions: activeQuestions, onRestart: switchScreen),
      _ => HomeScreen(homeColorStart, switchScreen),
    };



    return Scaffold(
      body: SizedBox.expand( // Occupy the entire screen
        child: DecoratedBox( // Apply gradient background to whatever screen widget is being displayed
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [homeColorStart, homeColorEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          //child: activeScreen ?? HomeScreen(homeColorStart, switchScreen),
          //child: activeScreen == 'start-screen' ? screenWidget : QuestionsScreen(),
          child: screenWidget,
        ),
      ),
    );
  }
}