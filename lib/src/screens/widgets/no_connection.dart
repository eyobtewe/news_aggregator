import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/blocs.dart';
import '../../core/core.dart';

Scaffold buildNoConnection(void Function() onPressed, UiBloc uiBloc) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            child: const Icon(Icons.wifi_off, size: 42, color: cGrey),
          ),
          const Divider(color: cTransparent),
          const Divider(color: cTransparent),
          const Divider(color: cTransparent),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    side: const BorderSide(color: cGrey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            child: Text(
              Language.locale(uiBloc.lang, 'try_again'),
              style: TextStyle(
                color: cGrey,
                fontFamily: (uiBloc.lang == 'en' || uiBloc.lang == 'all')
                    ? GoogleFonts.openSans().fontFamily
                    : 'Ny',
                fontFamilyFallback: kFontFallback,
              ),
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    ),
  );
}
