import 'package:dartz/dartz.dart';
import 'package:feedback/src/core/exception.dart';

abstract class QuestionService {
  Future<Either<QuestionException, Map<String, dynamic>>> submitAnswers({
    required Map<int, String> answers,
    required String typeQuestion,
    required String formQuestion,
  });

  Future<Either<QuestionException, Map<String, dynamic>>>
      submitAnswersOffline();

  Future<Either<QuestionException, Map<String, dynamic>>>
      storageAnswersOffline({
    required Map<int, String> answers,
    required String typeQuestion,
    required String formQuestion,
  });
}
