import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/blocs.dart';
import '../../core/core.dart';
import '../screens.dart';

// enum VIEW { grid, tile, masonary }

class DynamicSliverAppBar extends StatefulWidget {
  const DynamicSliverAppBar({Key key, this.index}) : super(key: key);

  final int index;

  @override
  _DynamicSliverAppBarState createState() => _DynamicSliverAppBarState();
}

class _DynamicSliverAppBarState extends State<DynamicSliverAppBar> {
  VIEW uiStyle = VIEW.tile;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uiBloc = UiProvider.of(context);
    ScreenUtil.init(context, allowFontScaling: true, designSize: size);
    return SliverAppBar(
      pinned: true,
      // floating: true,
      // snap: true,
      title: Text(
        Language.locale(uiBloc.lang, 'app_name'),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: kOldFonts[0],
          // fontFamilyFallback: kFontFallback,
          fontSize: ScreenUtil().setSp(28),
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              if (uiStyle == VIEW.tile) {
                setState(() {
                  uiStyle = VIEW.grid;
                });
                // } else if (uiStyle == VIEW.grid) {
                //   setState(() {
                //     uiStyle = VIEW.masonary;
                //   });
              } else {
                setState(() {
                  uiStyle = VIEW.tile;
                });
              }
            },
            icon: Icon(
              uiStyle == VIEW.tile
                  ? Icons.web_asset
                  : uiStyle == VIEW.grid
                      ? Icons.auto_awesome_mosaic_outlined
                      : Icons.list,
            ))
      ],
    );
  }
}
