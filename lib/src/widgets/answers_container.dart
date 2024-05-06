import 'package:feedback/src/bloc/questions_bloc.dart';
import 'package:feedback/src/models/entities/question_entity.dart';
import 'package:feedback/src/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerContainer extends StatefulWidget {
  final QuestionEntity question;
  final String answer;
  final TextEditingController controller;
  const AnswerContainer({
    super.key,
    required this.controller,
    required this.question,
    required this.answer,
  });
  @override
  State<AnswerContainer> createState() => _AnswerContainerState();
}

class _AnswerContainerState extends State<AnswerContainer> {
  static final InputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.primary, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return widget.question.alternatives.isEmpty
        ? Container(
            padding: const EdgeInsets.all(20),
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
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'Resposta',
                  border: _inputBorder,
                  enabledBorder: _inputBorder,
                  focusedBorder: _inputBorder,
                  label: const Text('Resposta'),
                ),
                minLines: 3,
                maxLines: 5,
              ),
            ),
          )
        : Column(
            children: widget.question.alternatives
                .map<Widget>(
                  (alternative) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                    child: RadioListTile(
                      toggleable: true,
                      title: Text(
                        alternative,
                        style: GoogleFonts.baloo2(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      value: alternative,
                      groupValue: widget.answer,
                      onChanged: (value) {
                        context.read<QuestionBloc>().add(
                              SetAnswerQuestionEvent(
                                answer: value ?? "",
                                questionNumber: widget.question.questionNumber,
                              ),
                            );
                      },
                    ),
                  ),
                )
                .toList(),
          );
  }
}
