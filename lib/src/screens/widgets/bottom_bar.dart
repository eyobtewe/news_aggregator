import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../bloc/blocs.dart';
import '../../core/core.dart';
import '../../domain/services/firebase.dart';

class BottomBar extends StatelessWidget {
  final int index;

  const BottomBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = UiProvider.of(context);
    ScreenUtil.init(context, allowFontScaling: true, designSize: size);
    return buildBottomNavigationBar(context, bloc, size);
  }

  Widget buildBottomNavigationBar(
      BuildContext context, UiBloc bloc, Size size) {
    return BottomNavigationBar(
      items: items(bloc),
      iconSize: 20,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor:
          Theme.of(context).colorScheme.secondary.withOpacity(0.75),
      selectedLabelStyle: _textStyle,
      unselectedLabelStyle: _textStyle,
      showUnselectedLabels: true,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      onTap: (int i) {
        switch (i) {
          case 0:
            queryDocumentSnapshot = null;
            Navigator.pushReplacementNamed(context, rHomePage);
            break;
          case 1:
            // showSearch(context: context, delegate: ArticleSearch());
            Navigator.pushReplacementNamed(context, rSearchPage);
            break;
          case 2:
            Navigator.pushReplacementNamed(context, rBookmarkPage);
            break;
          case 3:
            Navigator.pushReplacementNamed(context, rSettingPage);
            break;
          default:
            // queryDocumentSnapshot = null;
            Navigator.pushReplacementNamed(context, rHomePage);
            break;
        }
      },
    );
  }

  List<BottomNavigationBarItem> items(UiBloc bloc) {
    final news = bottomNavigationBarItem(bloc, 0, 'news');
    final search = bottomNavigationBarItem(bloc, 1, 'search');
    final favorite = bottomNavigationBarItem(bloc, 2, 'favorite');
    final setting = bottomNavigationBarItem(bloc, 3, 'setting');

    return [news, search, favorite, setting];
  }

  BottomNavigationBarItem bottomNavigationBarItem(
      UiBloc bloc, int i, String label) {
    List icons = [
      Ionicons.home_outline,
      Ionicons.search_outline,
      Ionicons.bookmark_outline,
      Ionicons.settings_outline,
      Ionicons.home,
      Ionicons.search,
      Ionicons.bookmark,
      Ionicons.settings,
    ];
    return BottomNavigationBarItem(
      icon: Icon(icons[i]),
      activeIcon: Icon(icons[i + 4]),
      label: Language.locale(bloc.lang, label),
    );
  }
}

final _textStyle = TextStyle(
  fontFamilyFallback: kFontFallback,
  // fontSize: ScreenUtil().setSp(12),
  fontSize: 0,
  fontFamily: GoogleFonts.openSans().fontFamily,
  // height: 1.5,
);
