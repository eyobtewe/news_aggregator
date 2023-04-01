import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../domain/schemas/schema.dart';
import '../../widgets/widgets.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({Key key, this.article}) : super(key: key);

  final Post article;

  @override
  Widget build(BuildContext context) {
    String title = textCleanUp(article.title.rendered);

    final Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context, designSize: size, allowFontScaling: true);

    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamilyFallback: kFontFallback,
        color: Theme.of(context).colorScheme.secondary,
        fontFamily: 'Oswald',
        fontSize: ScreenUtil().setSp(14),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.left,
    );
  }
}
