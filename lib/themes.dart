import 'package:flutter/material.dart';

final theme = ThemeData(
    brightness: Brightness.dark,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    primaryColor: primaryColor,
    accentColor: accentColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor, selectionColor: accentColorDark),
        iconTheme: IconThemeData(
          color: accentColorLight
        ));

const primaryColor = Color(0xFF303f9f);
const primaryColorLight = Color(0xFF666ad1);
const primaryColorDark = Color(0xFF001970);

const accentColor = Color(0xFF80cbc4);
const accentColorLight = Color(0xFFb2fff7);
const accentColorDark = Color(0xFF4f9b94);

const textColorOnPrimary = Color(0xFFFFFFFF);
const textColorOnAccent = Color(0xFF000000);