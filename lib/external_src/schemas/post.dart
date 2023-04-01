import 'package:meta/meta.dart';

import '../flutter_wordpress.dart';
import 'content.dart';

class Post {
  int id;
  String date;
  String link;

  List<int> categories;

  String source, lang;

  Content title, content;
  // Content excerpt;

  String image;

  // Media featuredMedia;

  Post({
    this.date,
    @required String title,
    @required String content,
    String excerpt,
    // String featuredMedia,
    this.categories,
    // this.featuredMediaID,
  })  : title = Content(rendered: title),
        // this.excerpt = Content(rendered: excerpt),
        // this.featuredMedia = Media(sourceUrl: featuredMedia),
        content = Content(rendered: content);

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    source = json['source'];
    lang = json['language'];
    image = json['jetpack_featured_media_url'];

    // featuredMediaID = json['featured_media'];
    if (json['categories'] != null) {
      categories = json['categories'].cast<int>();
    } else {
      categories = null;
    }

    link = json['link'];
    title = json['title'] != null ? Content.fromJson(json['title']) : null;
    // excerpt = json['excerpt'] != null ? Content.fromJson(json['excerpt']) : null;
    // featuredMedia = json['featured_media_data'] != null
    //     ? Media.fromJson(json['featured_media_data'])
    //     : null;
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, String> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (date != null) data['date'] = date;
    if (id != null) data['id'] = id.toString();
    if (image != null) data['jetpack_featured_media_url'] = image;
    // if (this.categories != null) data['categories'] = listToUrlString(this.categories);

    if (title != null) data['title'] = title.toJson().toString();
    if (content != null) data['content'] = content.toJson().toString();
    // if (this.excerpt != null) data['excerpt'] = this.excerpt.toJson().toString();
    // if (this.featuredMedia != null)
    //   data['featured_media_data'] = this.featuredMedia.toJson().toString();
    // if (this.featuredMediaID != null)
    //   data['featured_media'] = this.featuredMediaID.toString();
    return data;
  }

  @override
  String toString() {
    return 'Post: { id: $id, title: ${title.rendered}, ';
  }
}
