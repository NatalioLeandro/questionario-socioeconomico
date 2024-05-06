import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final int questionNumber;
  final String question;
  final List<String> alternatives;

  const QuestionEntity({
    required this.questionNumber,
    required this.question,
    this.alternatives = const [],
  });

  @override
  List<Object?> get props => [
        questionNumber,
        question,
        ...alternatives,
      ];
}
