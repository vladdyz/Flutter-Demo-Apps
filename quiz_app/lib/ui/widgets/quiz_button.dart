import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  // changed positional args to named parameters
  const QuizButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor,
    this.isAnswerButton,
    this.isRefreshButton,
  });

  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final bool? isAnswerButton;
  final bool? isRefreshButton;

  @override
  Widget build(BuildContext context) {
    final buttonColor = backgroundColor ?? Colors.indigo;

    // Quiz Answer buttons do not have icons
    bool answerButton = isAnswerButton ?? false;
    // Refresh button has a different icon
    bool refreshButton = isRefreshButton ?? false;

    // Note: The buttons in this app generally have the same configuration with some minor differences
    // However, if the implementation continues adding stylistic changes between the various screens,
    // consider conditionally rendering different button configs from a list instead of using ternary
    // operators in individual properties within a single return

    return ElevatedButton.icon(
      onPressed: () {
        onPressed();
      },
      icon: refreshButton
          ? const Icon(Icons.refresh)
          : (answerButton
                ? SizedBox.shrink()
                : const Icon(Icons.arrow_right_alt)),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        padding: answerButton
            ? EdgeInsets.symmetric(vertical: 10, horizontal: 40)
            : EdgeInsets.all(20),
      ),
      label: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
