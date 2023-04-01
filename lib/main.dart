import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'src/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.initialize();
  // MobileAds.setTestDeviceIds(['0285E4EA075685841E958F067765106D']);

  await Firebase.initializeApp();

  redApp();
  runApp(const App());
}

redApp() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

// keytool -genkey -v -keystore key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
// keytool -importkeystore -srckeystore key.jks -destkeystore key.jks -deststoretype pkcs12
// keytool -list -v -alias key -keystore key.jks

