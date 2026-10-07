import 'package:flutter/material.dart';
//import 'package:quiz_app/ui/screens/home_screen.dart';
import 'package:quiz_app/ui/widgets/quiz.dart';

const gradientColorStart = Color.fromARGB(255, 96, 13, 121); // Start Gradient
const gradientColorEnd = Color.fromARGB(255, 177, 42, 218); // End Gradient

void main() {
  runApp(const MaterialApp(home: Quiz(gradientColorStart, gradientColorEnd)));
}
