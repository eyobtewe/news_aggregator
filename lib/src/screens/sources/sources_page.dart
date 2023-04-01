import 'package:flutter/material.dart';

import '../../bloc/apis_provider.dart';
import '../../core/core.dart';
import '../../domain/schemas/schema.dart';
import 'sources_based.dart';

class SourcesPage extends StatefulWidget {
  const SourcesPage({Key key}) : super(key: key);

  @override
  _SourcesPageState createState() => _SourcesPageState();
}

class _SourcesPageState extends State<SourcesPage> {
  ApisBloc bloc;
  Size size;

  @override
  Widget build(BuildContext context) {
    bloc = ApisProvider.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sources'),
      ),
      body: FutureBuilder(
        future: bloc.getNewsSources(),
        initialData: bloc.newsSources,
        builder: (_, AsyncSnapshot<List<NewsSource>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Container();
          } else {
            return buildSources(snapshot.data, context);
          }
        },
      ),
    );
  }

  Widget buildSources(List<NewsSource> categories, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView.builder(
        itemCount: (categories.length / 2).ceil(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              buildSourceBtn(context, categories[index * 2]),
              if ((index * 2 + 1) < categories.length)
                buildSourceBtn(context, categories[index * 2 + 1]),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }

  // Widget buildBtnsListView(BuildContext context, List<dynamic> categories) {
  //   return ListView(
  //     shrinkWrap: true,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               buildSourceBtn(context, categories[0]),
  //               buildSourceBtn(context, categories[1]),
  //               buildSourceBtn(context, categories[2]),
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildSourceBtn(context, categories[3]),
  //               buildSourceBtn(context, categories[4]),
  //               buildSourceBtn(context, categories[5]),
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildSourceBtn(context, categories[6]),
  //               buildSourceBtn(context, categories[7]),
  //               buildSourceBtn(context, categories[8]),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget buildSourceBtn(BuildContext context, NewsSource e) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return SourcesBased(newsSource: e.name);
            },
          ),
        );
      },
      child: buildBtnLabel(e, context),
    );
  }

  Widget buildBtnLabel(dynamic e, BuildContext context) {
    return Container(
      width: size.width / 2.2,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        e.name,
        style: TextStyle(
          fontFamilyFallback: kFontFallback,
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
