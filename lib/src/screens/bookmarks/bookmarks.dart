import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../bloc/blocs.dart';
import '../../core/core.dart';
import '../../domain/schemas/schema.dart';
import '../widgets/widgets.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key key}) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

CacheBloc bloc;
UiBloc uiBloc;
Size size;
List<Post> posts = [];

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    bloc = CacheProvider.of(context);
    uiBloc = UiProvider.of(context);
    size = MediaQuery.of(context).size;
    ScreenUtil.init(context, designSize: size, allowFontScaling: true);

    return FutureBuilder(
      future: bloc.fetchSavedPosts(uiBloc.lang),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            // bottomNavigationBar: BottomBar(index: 2),
            appBar: buildAppBar([], context),
            body: const Center(child: CustomCircularLoader()),
          );
        } else {
          posts = snapshot.data;

          return posts.isEmpty
              ? Scaffold(
                  // bottomNavigationBar: BottomBar(index: 2),
                  appBar: buildAppBar([], context),
                  body: const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Icon(Icons.delete_outline_rounded, size: 40),
                    ),
                  ),
                )
              : Scaffold(
                  // bottomNavigationBar: BottomBar(index: 2),
                  appBar: buildAppBar(posts, context),
                  body: buildListView(),
                );
        }
      },
    );
  }

  ListView buildListView() {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int i) =>
          const Divider(color: cTransparent, thickness: 5, height: 10),
      itemCount: posts.length,
      itemBuilder: (_, int i) => PostTile(article: posts[i], page: 4),
    );
  }
}

Widget buildAppBar(List<Post> savedArticles, BuildContext context) {
  return AppBar(
    centerTitle: false,
    title: Text(Language.locale(uiBloc.lang, 'favorite')),
    actions: [
      savedArticles.isEmpty
          ? Container()
          : IconButton(
              icon: const Icon(Ionicons.trash_sharp),
              onPressed: () async {
                await _showDialog(context);
              },
            ),
    ],
  );
}

_showDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext ctx) => AlertDialog(
      content:
          const Text('Are you sure you want to delete all saved articles?'),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              cGrey,
            ),
          ),
          onPressed: () async {
            await bloc.clearAll(uiBloc.lang);
            // buildShowToast('Deleted all saved articles');
            Navigator.pushNamedAndRemoveUntil(
              context,
              rBookmarkPage,
              (Route<dynamic> route) => false,
            );
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: cWhite),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              cPrimaryColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'No',
            style: TextStyle(color: cWhite),
          ),
        )
      ],
    ),
  );
}
