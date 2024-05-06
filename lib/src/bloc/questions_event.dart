part of "questions_bloc.dart";

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class NextQuestionEvent extends QuestionEvent {}

class PreviousQuestionEvent extends QuestionEvent {}

class ClearAnswersEvent extends QuestionEvent {}

class SetAnswerQuestionEvent extends QuestionEvent {
  final int questionNumber;
  final String answer;
  const SetAnswerQuestionEvent({
    required this.questionNumber,
    required this.answer,
  });

  @override
  List<Object> get props => [answer, questionNumber];
}

class SubmitAnswersEvent extends QuestionEvent {}
