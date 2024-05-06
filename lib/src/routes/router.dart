import 'package:feedback/src/bloc/questions_bloc.dart';
import 'package:feedback/src/core/inject.dart';
import 'package:feedback/src/screens/home_screen.dart';
import 'package:feedback/src/screens/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String home = '/';
  static const String productorQuestionsOpen = '/productor-questions-open';
  static const String productorQuestionsClose = '/productor-questions-close';

  static const String participantQuestionsOpen = '/participant-questions-open';
  static const String participantQuestionsClose = '/participant-questions-close';

  static bool falsePredicate(Route<dynamic> route) => false;

  static String get initialRoute => home;

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(),
    productorQuestionsOpen: (context) => BlocProvider(
          create: (context) => QuestionBloc(
            questionType: QuestionType.productor,
            question: Question.openEnded,
            questionService: getIt(),
          ),
          child: const QuestionScreen(),
        ),
    productorQuestionsClose: (context) => BlocProvider(
          create: (context) => QuestionBloc(
            questionType: QuestionType.productor,
            question: Question.multipleChoice,
            questionService: getIt(),
          ),
          child: const QuestionScreen(),
        ),


    participantQuestionsOpen: (context) => BlocProvider(
          create: (context) => QuestionBloc(
            questionType: QuestionType.participant,
            question: Question.openEnded,
            questionService: getIt(),
          ),
          child: const QuestionScreen(),
        ),
    participantQuestionsClose: (context) => BlocProvider(
          create: (context) => QuestionBloc(
            questionType: QuestionType.participant,
            question: Question.multipleChoice,
            questionService: getIt(),
          ),
          child: const QuestionScreen(),
        ),
  };
}
