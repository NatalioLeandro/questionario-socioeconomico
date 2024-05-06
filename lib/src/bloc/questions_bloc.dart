import 'package:equatable/equatable.dart';
import 'package:feedback/src/core/constants.dart';
import 'package:feedback/src/models/entities/question_entity.dart';
import 'package:feedback/src/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionType questionType;
  final Question question;
  final QuestionService questionService;

  QuestionBloc(
      {required this.questionType,
      required this.questionService,
      required this.question})
      : super(QuestionState(questionType: questionType, question: question)) {
    on<NextQuestionEvent>(_onNextQuestion);
    on<PreviousQuestionEvent>(_onPreviousQuestion);
    on<ClearAnswersEvent>(_onClearAnswers);
    on<SetAnswerQuestionEvent>(_onSetAnswerQuestion);
    on<SubmitAnswersEvent>(_onSubmitAnswers);
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuestionState> emit) {
    final currentState = state;
    if (!currentState.isLastQuestion) {
      emit(
        currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
        ),
      );
    }
  }

  void _onPreviousQuestion(
      PreviousQuestionEvent event, Emitter<QuestionState> emit) {
    final currentState = state;
    if (currentState.currentQuestionIndex > 1) {
      emit(
        currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex - 1,
        ),
      );
    }
  }

  void _onClearAnswers(ClearAnswersEvent event, Emitter<QuestionState> emit) {
    emit(state.copyWith(answers: {}));
  }

  void _onSetAnswerQuestion(
    SetAnswerQuestionEvent event,
    Emitter<QuestionState> emit,
  ) {
    final currentState = state;
    final updatedAnswers = {
      ...currentState.answers,
      event.questionNumber: event.answer,
    };
    emit(currentState.copyWith(answers: updatedAnswers));
  }

  Future<void> _onSubmitAnswers(
    SubmitAnswersEvent event,
    Emitter<QuestionState> emit,
  ) async {
    final currentState = state;
    emit(currentState.copyWith(status: QuestionStatus.loading));

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      var response = await questionService.storageAnswersOffline(
        answers: currentState.answers,
        typeQuestion: questionType.toString(),
        formQuestion: question.toString(),
      );

      response.fold(
            (error) =>
            emit(
              currentState.copyWith(
                status: QuestionStatus.error,
                errorMessage: error.message,
              ),
            ),
            (data) =>
            emit(currentState.copyWith(status: QuestionStatus.success)),
      );
      return;
    } else {
      var response = await questionService.submitAnswers(
        answers: currentState.answers,
        typeQuestion: questionType.toString(),
        formQuestion: question.toString(),
      );

      response.fold(
            (error) =>
            emit(
              currentState.copyWith(
                status: QuestionStatus.error,
                errorMessage: error.message,
              ),
            ),
            (data) =>
            emit(currentState.copyWith(status: QuestionStatus.success)),
      );
    }
  }
}
