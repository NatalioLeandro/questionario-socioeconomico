import 'package:feedback/src/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onBackPressed;
  const QuizAppBar({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: onBackPressed != null
          ? TextButton.icon(
              style: TextButton.styleFrom(
                iconColor: AppColors.foregroundColor,
                foregroundColor: AppColors.foregroundColor,
              ),
              icon: const Icon(Icons.arrow_back_ios, size: 12),
              label: Text('Voltar', style: GoogleFonts.baloo2(fontSize: 12)),
              onPressed: onBackPressed,
            )
          : null,
      leadingWidth: 100,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.baloo2(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
