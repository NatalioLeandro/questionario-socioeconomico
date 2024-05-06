part of "questions_bloc.dart";

enum QuestionStatus { initial, loading, success, error }

enum QuestionType { productor, participant }

enum Question { openEnded, multipleChoice }

class QuestionState extends Equatable {
  final QuestionStatus status;
  final int currentQuestionIndex;
  final String currentAnswerText;
  final Map<int, String> answers;
  final QuestionType questionType;
  final String errorMessage;
  final Question question;

  const QuestionState({
    this.status = QuestionStatus.initial,
    this.currentQuestionIndex = 1,
    this.currentAnswerText = "",
    required this.questionType,
    this.errorMessage = "",
    this.answers = const {},
    required this.question,
  });

  QuestionState copyWith({
    QuestionStatus? status,
    int? currentQuestionIndex,
    Map<int, String>? answers,
    String? errorMessage,
    String? currentAnswerText,
  }) =>
      QuestionState(
        status: status ?? this.status,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        questionType: questionType,
        errorMessage: errorMessage ?? this.errorMessage,
        currentAnswerText: currentAnswerText ?? this.currentAnswerText,
        answers: answers ?? this.answers,
        question: question,
      );

  @override
  List<Object> get props => [
        status,
        currentQuestionIndex,
        questionType,
        answers,
        errorMessage,
        currentAnswerText,
        question,
      ];

  List<QuestionEntity> get questions {
    if (questionType == QuestionType.productor) {
      if (question == Question.openEnded) {
        return farmerQuestions;
      } else {
        return farmerQuestions;
      }
    } else {
      if (question == Question.openEnded) {
        return participantQuestions;
      } else {
        return participantQuestions;
      }
    }
  }

  int get totalQuestions => questions.length;

  QuestionEntity get currentQuestion => questions.firstWhere(
        (question) => question.questionNumber == currentQuestionIndex,
      );

  String get currentAnswer => answers[currentQuestionIndex] == null
      ? ""
      : answers[currentQuestionIndex]!;

  bool get isLastQuestion => currentQuestionIndex == totalQuestions;
}
