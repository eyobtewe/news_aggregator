import 'package:meta/meta.dart';

import 'content.dart';
import 'media.dart';
import 'title.dart';

class Post {
  int id;
  String date;

  int featuredMediaID;
  String link;

  String source;

  Title title;
  Content content;

  Media featuredMedia;

  Post({
    this.date,
    this.source,
    @required String title,
    @required String content,
    String featuredMedia,
    this.featuredMediaID,
  })  : title = Title(rendered: title),
        featuredMedia = Media(sourceUrl: featuredMedia),
        content = Content(rendered: content);

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    source = json['source'];
    featuredMediaID = json['featured_media'];

    link = json['link'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    featuredMedia = json['featured_media_data'] != null
        ? Media.fromJson(json['featured_media_data'])
        : null;
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (date != null) data['date'] = date;
    if (source != null) data['source'] = date;
    if (id != null) data['id'] = id;

    if (title != null) data['title'] = title.toJson();
    if (content != null) data['content'] = content.toJson();
    if (featuredMedia != null) {
      data['featured_media_data'] = featuredMedia.toJson();
    }
    if (featuredMediaID != null) data['featured_media'] = featuredMediaID;
    return data;
  }

  @override
  String toString() {
    return 'Post: { id: $id, title: ${title.rendered}, ';
  }
}

class NewsSource {
  String name;
  String url;

  NewsSource({this.name, this.url});

  NewsSource.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (url != null) data['url'] = url;

    return data;
  }
}
