import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../bloc/blocs.dart';
import '../core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  ApisBloc aBloc;
  UiBloc uiBloc;
  // bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    aBloc = ApisProvider.of(context);
    uiBloc = UiProvider.of(context);
    final themeProvider = Provider.of<ThemeNotifier>(context);
    goToHomeScreen(context);

    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context, designSize: size, allowFontScaling: true);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset(themeProvider.darkTheme ? logoWhtie : logoBlack),
            width: size.width / 4,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              Language.locale(uiBloc.lang, 'app_name'),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                color: Theme.of(context).colorScheme.secondary,
                fontFamilyFallback: kFontFallback,
                fontFamily: kOldFonts[0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void goToHomeScreen(BuildContext ctx) async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushNamedAndRemoveUntil(context, rHomePage, (route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

const String logoWhtie = 'assets/images/ee-white.png';
const String logoBlack = 'assets/images/ee-black.png';

const List<String> kOldFonts = [
  // 'Washington-Text-Regular',
  // 'Knights-Quest',
  // 'Canterbury',
  'Chomsky',
  'FenwickWoodtype',
];
