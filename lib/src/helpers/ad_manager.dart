// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';
// import 'package:flutter_native_admob/native_admob_options.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../screens/screens.dart';

// class BuildAd extends StatefulWidget {
//   const BuildAd({
//     Key key,
//     this.view,
//     this.adPlace,
//     this.height,
//     this.nativeAdController,
//   }) : super(key: key);

//   final VIEW view;
//   final AdPlace adPlace;

//   final int height;
//   final NativeAdmobController nativeAdController;

//   @override
//   _BuildAdState createState() => _BuildAdState();
// }

// class _BuildAdState extends State<BuildAd> {
//   // NativeAdmobController nativeAdController;

//   final _nativeAdController = NativeAdmobController();
//   double _height = 0;

//   StreamSubscription _subscription;

//   void _onStateChanged(AdLoadState state) {
//     if (state == AdLoadState.loadCompleted) {
//       setState(() {
//         _height = widget.view == VIEW.grid ? 300 : 130;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     debugPrint('-----------------INIT-----------------');

//     _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();

//     _nativeAdController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     ScreenUtil.init(context, designSize: size, allowFontScaling: true);
//     final theme = Theme.of(context);

//     NativeTextStyle normalTextStyle = NativeTextStyle(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       color: theme.colorScheme.secondary,
//     );
//     NativeTextStyle reverseTextStyle = NativeTextStyle(
//       color: theme.scaffoldBackgroundColor,
//       backgroundColor: theme.colorScheme.secondary,
//     );

//     return Container(
//       height: ScreenUtil().setHeight(_height),
//       width: size.width,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: NativeAdmob(
//         numberAds: 1,
//         type: widget.view != VIEW.grid ? NativeAdmobType.banner : NativeAdmobType.full,
//         error: Container(),
//         adUnitID: adUnitIds[widget.adPlace],
//         controller: _nativeAdController,
//         options: NativeAdmobOptions(
//           showMediaContent: true,
//           adLabelTextStyle: reverseTextStyle,
//           storeTextStyle: normalTextStyle,
//           callToActionStyle: reverseTextStyle,
//           bodyTextStyle: normalTextStyle,
//           headlineTextStyle: normalTextStyle,
//           advertiserTextStyle: normalTextStyle,
//           priceTextStyle: normalTextStyle,
//         ),
//         loading: Container(),
//       ),
//     );
//   }
// }

// enum AdPlace {
//   IN_POST,
//   BETWEEN_ARTICLES,
// }
// Map<AdPlace, String> adUnitIds = {
//   AdPlace.IN_POST: 'ca-app-pub-3672981091472505/9221519050',
//   AdPlace.BETWEEN_ARTICLES: 'ca-app-pub-3672981091472505/8056966416',
// };
