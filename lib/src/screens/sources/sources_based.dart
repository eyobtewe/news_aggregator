import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/core.dart';
import '../../domain/schemas/schema.dart';

import '../../bloc/blocs.dart';
import '../widgets/widgets.dart';

class SourcesBased extends StatefulWidget {
  const SourcesBased({
    Key key,
    this.newsSource,
    // this.id,
    // this.tag,
  }) : super(key: key);
  final String newsSource;
  // final int id;
  // final Tag tag;
  @override
  _SourcesBasedState createState() => _SourcesBasedState();
}

class _SourcesBasedState extends State<SourcesBased> {
  ApisBloc aBloc;
  UiBloc uiBloc;
  Size size;

  ScrollController scrollController;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    uiBloc = UiProvider.of(context);
    aBloc = ApisProvider.of(context);
    size = MediaQuery.of(context).size;

    ScreenUtil.init(context, designSize: size, allowFontScaling: true);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.newsSource ??
              //  widget.tag.name ??
              '',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: Theme.of(context).colorScheme.secondary,
            fontFamilyFallback: kFontFallback,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return FutureBuilder(
      // future: aBloc.fetchPosts(widget.id, 1, 25, tag: widget.tag),
      future:
          aBloc.getPosts(source: NewsSource(name: widget.newsSource, url: '')),
      initialData: aBloc.sourceBasedPosts[widget.newsSource],
      builder: (_, AsyncSnapshot<List<Post>> snapshot) {
        final Widget refresh = buildNoConnection(() => setState(() {}), uiBloc);

        if (!snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            return refresh;
          } else {
            return const Center(
              child: CustomCircularLoader(),
            );
          }
        } else if (snapshot.data.isEmpty) {
          return refresh;
        } else {
          return buildResult(snapshot.data);
        }
      },
    );
  }

  Widget buildResult(List<Post> snapshot) {
    return ListView.builder(
      itemBuilder: (BuildContext ctx, int index) {
        return PostTile(
          article: snapshot[index],
          page: 1,
          isFromSource: widget.newsSource != null ? false : true,
        );
      },
      itemCount: snapshot.length,
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_listener);
  }

  void _listener() {
    if (scrollController.position.atEdge &&
        scrollController.position.pixels != 0) {
      setState(() {
        page++;
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_listener);
    scrollController.dispose();
    super.dispose();
  }
}
