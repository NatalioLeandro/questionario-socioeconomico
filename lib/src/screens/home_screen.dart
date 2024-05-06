import 'package:feedback/src/core/inject.dart';
import 'package:feedback/src/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feedback/src/core/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feedback/src/routes/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final result =
                  await getIt<QuestionService>().submitAnswersOffline();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    result.fold(
                      (l) => l.message,
                      (r) => r['message'],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.sync),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(theme.colorScheme.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulário Socioeconômico',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                fontFamily: GoogleFonts.baloo2().fontFamily,
              ),
            ),
            Text(
              'beta 1.0',
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: SvgPicture.asset(
                            'assets/images/image1.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Espaçamento entre a imagem e os botões
                  buildColumn(
                  title: 'Selecione o perfil do(a) Entrevistado(a):',
                    onPressed1: () => Navigator.of(context).pushNamed(
                      Routes.productorQuestionsClose,
                    ),
                    onPressed2: () => Navigator.of(context).pushNamed(
                      Routes.participantQuestionsClose,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildColumn({
    required String title,
    required VoidCallback onPressed1,
    required VoidCallback onPressed2,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            fontFamily: GoogleFonts.baloo2().fontFamily,
          ),
        ),
        const SizedBox(height: 15),
        buildButtonWithIcon(text: 'Poder Público', onPressed: onPressed1),
        const SizedBox(height: 10),
        buildButtonWithIcon(text: 'Agricultor Familiar', onPressed: onPressed2),
      ],
    );
  }

  Widget buildButtonWithIcon({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          icon: const Icon(Icons.arrow_forward_ios),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
                fontFamily: GoogleFonts.baloo2().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
