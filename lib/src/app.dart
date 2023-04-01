import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'core/core.dart';
import 'helpers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';

FirebaseAnalytics kAnalytics;
FirebaseAnalyticsObserver screenObserver = FirebaseAnalyticsObserver(
  analytics: kAnalytics,
);

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UiProvider(
      child: CacheProvider(
          child: ApisProvider(
        child: ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            builder:
                (BuildContext context, ThemeNotifier notifier, Widget child) {
              return MaterialApp(
                navigatorObservers: [screenObserver],
                // theme: kTHEME,
                // theme: kDarkTHEME,
                theme: Provider.of<ThemeNotifier>(context).currentTheme,
                // darkTheme: kDarkTHEME,
                // themeMode: Provider.of<ThemeNotifier>(context).theme,
                // debugShowCheckedModeBanner: false,
                onGenerateRoute: routes,
                // home:const Scaffold(
                //   body: Center(child: CustomNativeAds()),
                //   backgroundColor: cGrey,
                // )
              );
            },
          ),
        ),
      )),
    );
  }
}
