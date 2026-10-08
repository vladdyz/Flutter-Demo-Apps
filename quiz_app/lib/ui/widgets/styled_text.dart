import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, this.fontSize, {super.key});

  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0), // Considered making padding a param but dont want to lose on compile time optimization
      child: Text(
        text,
        textAlign: TextAlign.center,
        // I recycle this for various sizes, so it can no longer be const
        // Note: Google Fonts also aren't defined as const either
        style: GoogleFonts.amaranth(
          color: const Color.fromARGB(150, 218, 217, 217),
          fontSize: fontSize ?? 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
