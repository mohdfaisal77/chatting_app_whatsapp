import 'package:chatting_app/config/colors.dart';
import 'package:flutter/material.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: dContainerColor,
    ),
    colorScheme: ColorScheme.dark(
      primary: dPrimaryColor,
      onPrimary: dOnBackgroundColor,
      background: dBackgroundColor,
      onBackground: dOncontainerColor,
      primaryContainer: dContainerColor,
      onPrimaryContainer: dOncontainerColor,
    ),
inputDecorationTheme: InputDecorationTheme(
  fillColor: dBackgroundColor,
  filled: true,
  border:UnderlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none
  )
),

textTheme: const TextTheme(
        headlineLarge:TextStyle(
                fontSize: 32,
                color: dPrimaryColor,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w800
        ),
        headlineMedium:TextStyle(
            fontSize: 30,
            color: dOnBackgroundColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600
        ),
        headlineSmall:TextStyle(
            fontSize: 20,
            color: dPrimaryColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600
        ),
  labelLarge:TextStyle(
      fontSize: 15,
      color: dOncontainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400
  ),
  labelMedium:TextStyle(
      fontSize: 12,
      color: dOncontainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400
  ),
  labelSmall:TextStyle(
      fontSize: 10,
      color: dOncontainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300
  ),
  bodyLarge:TextStyle(
      fontSize: 18,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500
  ),
  bodyMedium:TextStyle(
      fontSize: 15,
      color: dOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400
  ),
)
);
