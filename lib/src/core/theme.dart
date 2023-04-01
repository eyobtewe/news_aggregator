import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/custom_route.dart';
import 'app_colors.dart';

final kTHEME = ThemeData(
  scaffoldBackgroundColor: cWhite,
  primaryColor: cPurecBlack,
  // fontFamily: 'SF',
  textTheme: GoogleFonts.openSansTextTheme(),
  pageTransitionsTheme: newMethod(),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: cBlack),
    toolbarTextStyle: lightTextStyle,
    titleTextStyle: lightTextStyle,
    actionsIconTheme: const IconThemeData(color: cBlack),
    backgroundColor: cWhite,
  ),
  buttonTheme: const ButtonThemeData(buttonColor: cGrey),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: cBlack,
    brightness: Brightness.light,
  ),
);

final kSepiaTheme = ThemeData(
  scaffoldBackgroundColor: cSepia,
  primaryColor: cPurecBlack,
  // fontFamily: 'SF',
  textTheme: GoogleFonts.openSansTextTheme(),
  pageTransitionsTheme: newMethod(),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: cBlack),
    toolbarTextStyle: lightTextStyle,
    titleTextStyle: lightTextStyle,
    actionsIconTheme: const IconThemeData(color: cBlack),
    backgroundColor: cSepia,
  ),
  buttonTheme: const ButtonThemeData(buttonColor: cGrey),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: cBlack,
    brightness: Brightness.light,
  ),
);

ThemeData kDarkTHEME = ThemeData(
  // fontFamily: 'SF',
  textTheme: GoogleFonts.openSansTextTheme(),
  pageTransitionsTheme: newMethod(),
  scaffoldBackgroundColor: cBlack,
  appBarTheme: AppBarTheme(
    backgroundColor: cBlack,
    toolbarTextStyle: darkTextStyle,
    titleTextStyle: darkTextStyle,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: const IconThemeData(color: cLessWhite),
    actionsIconTheme: const IconThemeData(color: cLessWhite),
  ),
  buttonTheme: const ButtonThemeData(buttonColor: cGrey),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: cLessWhite,
    brightness: Brightness.dark,
  ),
);

final TextStyle lightTextStyle = GoogleFonts.openSans().copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: cBlack,
);
final TextStyle darkTextStyle = GoogleFonts.openSans().copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: cLessWhite,
);

PageTransitionsTheme newMethod() {
  return PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  );
}

const List<String> kFontFallback = ['Ny'];
