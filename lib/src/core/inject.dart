import 'package:feedback/src/services/service.dart';
import 'package:feedback/src/services/service_impl.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.I;

void injectDependencies() {
  getIt.registerSingleton<QuestionService>(QuestionServiceImpl());
}
