import 'package:feedback/src/bloc/questions_bloc.dart';
import 'package:feedback/src/widgets/answers_container.dart';
import 'package:feedback/src/widgets/question_container.dart';
import 'package:feedback/src/widgets/quiz_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController answerController = TextEditingController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionBloc, QuestionState>(
      listener: (context, state) async {
        answerController.text = state.currentAnswer;
        if (state.status == QuestionStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state.status == QuestionStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Respostas enviadas com sucesso!"),
              backgroundColor: Colors.green,
            ),
          );
          await Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: QuizAppBar(
            title: "${state.currentQuestionIndex}/${state.totalQuestions}",
            onBackPressed: () {
              if (state.currentQuestionIndex == 1) {
                Navigator.of(context).pop();
              } else {
                context.read<QuestionBloc>().add(PreviousQuestionEvent());
              }
            },
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              QuestionContainer(
                question: state.currentQuestion,
                totalQuestions: state.totalQuestions,
              ),
              const SizedBox(height: 20),
              AnswerContainer(
                controller: answerController,
                question: state.currentQuestion,
                answer: state.currentAnswer,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (answerController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Resposta não pode ser vazia!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (state.currentQuestion.alternatives.isEmpty) {
                    context.read<QuestionBloc>().add(
                          SetAnswerQuestionEvent(
                            questionNumber: state.currentQuestionIndex,
                            answer: answerController.text,
                          ),
                        );
                    answerController.clear();
                  }

                  if (state.currentQuestionIndex == state.totalQuestions) {
                    context.read<QuestionBloc>().add(SubmitAnswersEvent());
                  } else {
                    context.read<QuestionBloc>().add(NextQuestionEvent());
                  }
                },
                child: Text(
                  state.currentQuestionIndex == state.totalQuestions
                      ? "Enviar respostas"
                      : 'Próxima pergunta',
                  style: GoogleFonts.baloo2(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
