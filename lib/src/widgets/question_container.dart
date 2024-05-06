import 'package:feedback/src/models/entities/question_entity.dart';
import 'package:feedback/src/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionContainer extends StatelessWidget {
  final QuestionEntity question;
  final int totalQuestions;

  const QuestionContainer({
    super.key,
    required this.question,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 90 / 100 * 65),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: -10,
                blurRadius: 50,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Center(
            child: Text(
              question.question,
              style: GoogleFonts.baloo2(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  height: 90,
                  width: 90,
                  child: CircularProgressIndicator(
                    value: (question.questionNumber) / totalQuestions,
                    backgroundColor: AppColors.secondary,
                    strokeWidth: 8,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '${question.questionNumber}',
                  style: GoogleFonts.baloo2(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
