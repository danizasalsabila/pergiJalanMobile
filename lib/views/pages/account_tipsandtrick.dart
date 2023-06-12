import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pergijalan_mobile/config/theme_color.dart';

class TipsAndTrick extends StatefulWidget {
  const TipsAndTrick({super.key});

  @override
  State<TipsAndTrick> createState() => _TipsAndTrickState();
}

class _TipsAndTrickState extends State<TipsAndTrick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Tips & Trik",
          style: GoogleFonts.inter(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}