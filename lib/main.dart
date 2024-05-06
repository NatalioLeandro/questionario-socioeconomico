import 'package:feedback/src/core/inject.dart';
import 'package:feedback/src/routes/router.dart';
import 'package:feedback/src/core/theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback',
      theme: theme,
      routes: Routes.routes,
      initialRoute: Routes.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}