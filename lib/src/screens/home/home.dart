import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import '../widgets/custom_native_ads.dart';
import '../../domain/schemas/schema.dart';
import '../../core/core.dart';

import '../../bloc/blocs.dart';
import '../../domain/services/dynamic_link.dart';
import '../screens.dart';
import '../widgets/widgets.dart';

enum VIEW { normal, grid, tile } // ,masonary

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApisBloc aBloc;
  UiBloc uiBloc;
  Size size;

  ScrollController scrollController;
  int page = 1;

  VIEW uiStyle = VIEW.normal;

  @override
  void initState() {
    super.initState();

    checkDynamicLinks();
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

  @override
  Widget build(BuildContext context) {
    uiBloc = UiProvider.of(context);
    aBloc = ApisProvider.of(context);
    size = MediaQuery.of(context).size;

    ScreenUtil.init(context, designSize: size, allowFontScaling: true);

    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        color: Theme.of(context).scaffoldBackgroundColor,
        strokeWidth: 3,
        onRefresh: () async {
          aBloc.clearData();
          // await aBloc.fetchPosts(null, 1, 10);
          Navigator.pushNamedAndRemoveUntil(
            context,
            rHomePage,
            (route) => false,
          );
          // aBloc.init();
          // setState(() {
          //   page = 1;
          // });
        },
        child: buildBody(),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        Language.locale(uiBloc.lang, 'app_name'),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: kOldFonts[0],
          fontSize: ScreenUtil().setSp(28),
          fontWeight: FontWeight.normal,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, rSettingPage);
        },
        icon: const Icon(Ionicons.settings_outline),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (uiStyle == VIEW.tile) {
              setState(() {
                uiStyle = VIEW.grid;
              });
            } else if (uiStyle == VIEW.grid) {
              //   setState(() {
              //     uiStyle = VIEW.masonary;
              //   });
              // } else if (uiStyle == VIEW.masonary) {
              setState(() {
                uiStyle = VIEW.normal;
              });
            } else {
              setState(() {
                uiStyle = VIEW.tile;
              });
            }
          },
          icon: Icon(
            uiStyle == VIEW.normal
                ? Ionicons.list_outline
                : uiStyle == VIEW.tile
                    ? Ionicons.tablet_landscape_outline
                    // : uiStyle == VIEW.grid
                    //     ? Icons.auto_awesome_mosaic_outlined
                    : Icons.article_outlined,
          ),
        )
      ],
    );
  }

  Widget buildBody() {
    return FutureBuilder(
      future: aBloc.getPosts(),
      initialData: aBloc.posts,
      builder: (_, AsyncSnapshot<List<Post>> snapshot) {
        final Widget refresh = buildNoConnection(
          () {
            aBloc.clearData();
            Navigator.pushNamedAndRemoveUntil(
                context, rHomePage, (route) => false);
          },
          uiBloc,
        );

        if (!snapshot.hasData || snapshot.data.isEmpty) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: refresh);
          } else {
            return const Center(
              child: CustomCircularLoader(),
            );
          }
        } else {
          return buildContentUi(aBloc.posts);
        }
      },
    );
  }

  Widget buildContentUi(List<Post> snapshot) {
    // if (uiStyle == VIEW.masonary) {
    //   return buildPostMasonary(snapshot);
    // } else {
    return ListView.separated(
      itemCount: snapshot.length,
      controller: scrollController,
      shrinkWrap: true,
      separatorBuilder: (_, int index) {
        return ((index + 2) % 5 == 0 && (index + 2) != 0)
            ? CustomNativeAds(isSmall: !(uiStyle == VIEW.grid))
            : Container();
      },
      itemBuilder: (_, int index) {
        // return Container(
        //   color: snapshot[index].title.rendered.contains('Podcast')?Colors.grey:Colors.white,
        //   padding: const EdgeInsets.all(4),
        //   child: Text(snapshot[index].title.rendered),
        // );
        switch (uiStyle) {
          case VIEW.tile:
            return Column(
              children: [
                PostTile(article: snapshot[index], page: 1),
                (index + 1) == snapshot.length
                    ? const Center(child: CustomCircularLoader())
                    : Container(),
              ],
            );
          case VIEW.grid:
            return Column(
              children: [
                PostBox(article: snapshot[index]),
                (index + 1) == snapshot.length
                    ? const Center(child: CustomCircularLoader())
                    : Container(),
              ],
            );
          case VIEW.normal:
          default:
            {
              if (index % 7 == 0) {
                return PostBox(article: snapshot[index]);
              } else {
                return Column(
                  children: [
                    PostTile(article: snapshot[index], page: 1),
                    (index + 1) == snapshot.length
                        ? const Center(child: CustomCircularLoader())
                        : Container(),
                  ],
                );
              }
            }
            break;
        }
      },
    );
    // }
  }

  // Widget buildPostMasonary(List<Post> snapshot) {
  //   return StaggeredGridView.countBuilder(
  //     crossAxisCount: 2,
  //     shrinkWrap: true,
  //     itemCount: snapshot.length,
  //     controller: scrollController,
  //     itemBuilder: (BuildContext context, int index) {
  //       return InkWell(
  //         onTap: () {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (_) {
  //                 return PostDetail(post: snapshot[index]);
  //               },
  //             ),
  //           );
  //         },
  //         child: PostBox(article: snapshot[index]),
  //       );
  //     },
  //     staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
  //     mainAxisSpacing: 4.0,
  //     crossAxisSpacing: 4.0,
  //   );
  // }

  void checkDynamicLinks() async {
    await kDynamicLinkService.handleDynamicLinks(
      onLinkFound: (Map<String, String> id) {
        if (id != null) {
          return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PostDetail(id: id),
            ),
          );
        }
      },
    );
  }
}

Widget buildCachedNetworkImage(String url) {
  return Container(
    color: cTransparent,
    child: CachedNetworkImage(
      imageUrl: url,
      httpHeaders: const {"user-agent": "Mozilla/5.0"},
      imageBuilder: (_, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) => const SizedBox(height: 0, width: 0),
      errorWidget: (context, url, error) => Container(),
    ),
  );
}
