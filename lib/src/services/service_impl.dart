import 'package:dartz/dartz.dart';
import 'package:feedback/src/core/exception.dart';
import 'package:feedback/src/services/service.dart';
import 'package:feedback/src/core/access_api.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:convert';

final HasuraConnect hasuraConnect = HasuraConnect(
  url,
  headers: {'x-hasura-admin-secret': key},
);

class QuestionServiceImpl implements QuestionService {
  @override
  Future<Either<QuestionException, Map<String, dynamic>>> submitAnswers({
    required Map<int, String> answers,
    required String typeQuestion,
    required String formQuestion,
  }) async {
    try {
      Map<String, String> stringKeyAnswers =
          answers.map((key, value) => MapEntry(key.toString(), value));

      var mutation = r'''
      mutation answer($type: String, $form: String, $answers: json) {
        insert_answer(objects: {type: $type, form: $form, answers: $answers}) {
          affected_rows
        }
      }
      ''';

      var operationsDoc = await hasuraConnect.mutation(
        mutation,
        variables: {
          'type': typeQuestion,
          'form': formQuestion,
          'answers': stringKeyAnswers,
        },
      );

      return const Right({'message': 'Dados enviados com sucesso!'});
    } catch (e) {
      return Left(
        QuestionException(
          'Houve um erro ao enviar os dados. Verifique a conexão e tente novamente.',
        ),
      );
    }
  }

  @override
  Future<Either<QuestionException, Map<String, dynamic>>>
      submitAnswersOffline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> savedForms = prefs
            .getStringList('forms')
            ?.map((e) => jsonDecode(e))
            .cast<Map<String, dynamic>>()
            .toList() ??
        [];

    if (connectivityResult == ConnectivityResult.wifi &&
        savedForms.isNotEmpty) {
      for (var form in savedForms) {
        try {
          var mutation = r'''
          mutation answer($type: String, $form: String, $answers: json) {
            insert_answer(objects: {type: $type, form: $form, answers: $answers}) {
              affected_rows
            }
          }
          ''';

          var operationsDoc = await hasuraConnect.mutation(
            mutation,
            variables: {
              'type': form['type'],
              'form': form['form'],
              'answers': form['answers'],
            },
          );
        } catch (e) {
          return Left(
            QuestionException(
              'Houve um erro ao enviar os dados. Verifique a conexão e tente novamente.',
            ),
          );
        }
      }

      await prefs.remove('forms');
      return const Right({'message': 'Formulários enviados com sucesso!'});
    } else {
      if (connectivityResult == ConnectivityResult.none) {
        return Left(
          QuestionException(
            'Houve um erro ao enviar os dados. Verifique a conexão e tente novamente.',
          ),
        );
      } else {
        return const Right({'message': 'Não há formulários para enviar!'});
      }
    }
  }

  @override
  Future<Either<QuestionException, Map<String, dynamic>>>
      storageAnswersOffline({
    required Map<int, String> answers,
    required String typeQuestion,
    required String formQuestion,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> savedForms = prefs
              .getStringList('forms')
              ?.map((e) => jsonDecode(e))
              .cast<Map<String, dynamic>>()
              .toList() ??
          [];

      Map<String, String> stringKeyAnswers =
          answers.map((key, value) => MapEntry(key.toString(), value));
      Map<String, dynamic> form = {
        'type': typeQuestion,
        'form': formQuestion,
        'answers': stringKeyAnswers,
      };

      savedForms.add(form);
      await prefs.setStringList(
        'forms',
        savedForms.map((e) => jsonEncode(e)).toList(),
      );

      return const Right({'message': 'Dados salvos offline!'});
    } catch (e) {
      return Left(
        QuestionException(
          'Houve um erro ao salvar os dados offline. Tente novamente.',
        ),
      );
    }
  }
}
