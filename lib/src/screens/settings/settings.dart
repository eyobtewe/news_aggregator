import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import '../../helpers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/blocs.dart';
import '../../core/core.dart';
import '../screens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UiBloc uiBloc;
  ApisBloc aBloc;
  List<String> langs = ['All', 'English', 'ትግርኛ', 'አማርኛ'];
  List<String> langShort = ['all', 'en', 'tg', 'am'];
  ThemeNotifier theme;
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeNotifier>(context);
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context, allowFontScaling: true, designSize: size);
    uiBloc = UiProvider.of(context);
    aBloc = ApisProvider.of(context);

    return Scaffold(
      // bottomNavigationBar: BottomBar(index: 3),
      appBar: buildAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const Divider(color: cTransparent),
          buildInkWell(context, rSourcesPage, rSourcesPage),
          const Divider(color: cGrey),
          buildInkWell(context, rBookmarkPage, rBookmarkPage),
          const Divider(color: cGrey),
          buildThemeBtn(context, uiBloc),
          const Divider(color: cGrey),
          buildLangOptions(context, uiBloc),
          const Divider(color: cGrey),
          buildInkWell(context, 'review', appLink),
          const Divider(color: cGrey),
          buildInkWell(context, 'share', appLink),
        ],
      ),
    );
  }

  InkWell buildInkWell(BuildContext context, String name, String url) {
    Map<String, IconData> icons = {
      'contact-us': Ionicons.mail_sharp,
      'review': Ionicons.star_outline,
      'share': Ionicons.share_social_outline,
      'language': Ionicons.language_outline,
      rBookmarkPage: Ionicons.bookmark_outline,
      rSourcesPage: Ionicons.newspaper_outline,
    };

    return InkWell(
      onTap: () async {
        switch (name) {
          case rSourcesPage:
          case rBookmarkPage:
            Navigator.pushNamed(context, url);
            break;
          case 'share':
            Share.share(url);
            break;
          case 'review':
            launch(url);
            break;
          default:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomWebPage(url: url, title: ''),
              ),
            );
        }
      },
      child: buildContainerTitle(icons, name),
    );
  }

  Container buildContainerTitle(Map<String, IconData> icons, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icons[name], size: 20),
          const VerticalDivider(color: cTransparent),
          Text(
            name == rBookmarkPage
                ? 'Bookmarks'
                : Language.locale(uiBloc.lang, name) ?? '+',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontFamilyFallback: kFontFallback,
              fontSize: ScreenUtil().setSp(20),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThemeBtn(BuildContext context, UiBloc uiBloc) {
    Map<String, IconData> icons = {
      'lightTheme': Ionicons.sunny_outline,
      'sepiaTheme': Ionicons.eye_outline,
      'darkTheme': Ionicons.moon_outline,
    };
    return InkWell(
      child: buildContainerTitle(
          icons,
          !(Theme.of(context).scaffoldBackgroundColor == cBlack)
              ? !(Theme.of(context).scaffoldBackgroundColor == cSepia)
                  ? 'lightTheme'
                  : 'sepiaTheme'
              : 'darkTheme'),
      onTap: () {
        theme.toggleTheme();
      },
    );
  }

  Widget buildLangOptions(BuildContext context, UiBloc uiBloc) {
    Map<String, IconData> icons = {
      'language': Icons.translate,
    };
    return InkWell(
      child: buildContainerTitle(icons, 'language'),
      onTap: () async {
        await buildShowModalBottomSheet(context, uiBloc);
      },
    );
  }

  Future buildShowModalBottomSheet(BuildContext context, UiBloc uiBloc) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      builder: (BuildContext ctx) {
        return SizedBox(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextButton(uiBloc, 0, context),
              buildTextButton(uiBloc, 1, context),
              buildTextButton(uiBloc, 2, context),
              buildTextButton(uiBloc, 3, context),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextButton(UiBloc uiBloc, int i, BuildContext context) {
    return InkWell(
      onTap: () {
        uiBloc.changeLanguage(langShort[i]);
        // aBloc.iPosts.clear();
        setState(() {});
        Navigator.pushNamedAndRemoveUntil(context, kRoot, (route) => false);
      },
      child: Container(
        height: 40,
        width: 70,
        alignment: Alignment.center,
        child: Text(
          langs[i],
          style: TextStyle(
            color: uiBloc.lang == langShort[i]
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).colorScheme.secondary,
            fontFamilyFallback: kFontFallback,
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: BoxDecoration(
          color: uiBloc.lang == langShort[i]
              ? Theme.of(context).colorScheme.secondary
              : cGrey.withOpacity(0.25),
          borderRadius: BorderRadius.horizontal(
            left: i == 0 ? const Radius.circular(50) : const Radius.circular(0),
            right: i == 3 ? const Radius.circular(50) : const Radius.circular(0),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        Language.locale(uiBloc.lang, 'app_name'),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: kOldFonts[0],
          fontFamilyFallback: kFontFallback,
          fontSize: ScreenUtil().setSp(28),
          fontWeight: FontWeight.normal,
        ),
      ),
      centerTitle: true,
    );
  }
}

const appLink = 'https://play.google.com/store/apps/details?id=io.media.news.aggregator';
