import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Used by the questions screen, localized here for better maintainability, performance optimization
// and to keep the widget tree at a reasonable size in adherence to best practices

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: summaryData.length,
      itemBuilder: (context, index) {
        return SummaryItem(itemData: summaryData[index]);
      },
    );
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, required this.itemData});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrect = itemData['chosen_answer'] == itemData['correct_answer'];
    
    final indicatorColor = isCorrect 
        ? const Color.fromARGB(255, 75, 175, 120) 
        : const Color.fromARGB(255, 230, 90, 115);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numbered Circle Badge Indicator
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: indicatorColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${(itemData['questions_index'] as int) + 1}',
              style: const TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 20),
          
          // Question Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['question_text'] as String,
                  style: GoogleFonts.amaranth(
                    color: Colors.white, 
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${itemData['chosen_answer']}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 221, 163, 255),
                    fontSize: 14,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${itemData['correct_answer']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 55, 11, 186),
                    fontSize: 14,
                   // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
