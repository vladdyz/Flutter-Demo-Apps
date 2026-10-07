
// not a widget, but a reusable model for the questions data
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);
  final String text;
  final List<String> answers;

  // Copying to a new list to avoid mutating original data (which shuffle does)
  // and avoid using a cascade operator in my loop below because shuffle modifies in place
  // Note: the reason for the shuffle is not purely cosmetic, as the first answer is always correct
  List<String> get shuffledAnswers {
    final shuffledList = List.of(answers)..shuffle();
    return shuffledList;
  }


}