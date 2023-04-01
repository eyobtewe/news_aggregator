import 'dart:async' as async;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'constants.dart';
import 'requests/params.dart';
import 'schemas/schema.dart';

export 'constants.dart';
export 'requests/params.dart';
export 'schemas/schema.dart';

class WordPress {
  String _baseUrl;

  WordPress({@required String baseUrl}) {
    _baseUrl =
        baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
  }

  async.Future<List<Post>> fetchPosts(
      {@required ParamsPostList postParams,
      bool fetchFeaturedMedia = false,
      String postType = "posts",
      bool fetchAll = false}) async {
    if (fetchAll) {
      postParams = postParams.copyWith(perPage: 100);
    }

    final StringBuffer url = StringBuffer(_baseUrl + URL_WP_BASE + "/" + postType);

    url.write(postParams.toString());

    final String _route = '$url' + POST_FIELDS;

    // debugPrint('\n\n\n$_route\n\n\n');

    final response = await http.get(Uri.parse(_route));

    List<String> d = response.body.split('[{');
    // debugPrint('\n\nlength - ${d.length}\n\n');
    // debugPrint('\n\ status code - ${response.statusCode}\n\n');
    // debugPrint('\n\nfirst - ${d[0]}\n\n');
    // debugPrint('\n\nsecond - ${d[1]}\n\n');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<Post> posts = [];
      if (response.body == '[]') {
        // debugPrint('\n\ body - ${response.body}\n\n');
        return posts;
      }
      final list = json.decode('[{${d[1]}');
      // debugPrint('\n\nsecond - $list\n\n');

      for (final post in list) {
        posts.add(await _postBuilder(
          post: Post.fromJson(post),
          setFeaturedMedia: fetchFeaturedMedia,
        ));
      }

      if (fetchAll && response.headers["x-wp-totalpages"] != null) {
        final totalPages = int.parse(response.headers["x-wp-totalpages"]);

        for (int i = postParams.pageNum + 1; i <= totalPages; ++i) {
          posts.addAll(await fetchPosts(
            postParams: postParams.copyWith(pageNum: i),
            fetchFeaturedMedia: fetchFeaturedMedia,
          ));
        }
      }

      return posts;
    } else {
      try {
        WordPressError err = WordPressError.fromJson(json.decode(response.body));
        throw err;
      } catch (e) {
        throw WordPressError(message: response.body);
      }
    }
  }

  Future<Post> _postBuilder({
    Post post,
    bool setFeaturedMedia = false,
  }) async {
    // if (setFeaturedMedia) {
    //   List<Media> media = await fetchMediaList(
    //     params: ParamsMediaList(
    //       includeMediaIDs: [post.featuredMediaID],
    //     ),
    //   );
    //   if (media != null && media.length != 0) post.featuredMedia = media[0];
    // }

    return post;
  }

  // async.Future<List<Media>> fetchMediaList({@required ParamsMediaList params}) async {
  //   final StringBuffer url = new StringBuffer(_baseUrl + URL_MEDIA);

  //   url.write(params.toString());

  //   final response = await http.get(
  //     Uri.parse(url.toString()),
  //   );

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     List<Media> media = <Media>[];
  //     final list = json.decode(response.body);
  //     list.forEach((m) {
  //       media.add(Media.fromJson(m));
  //     });
  //     return media;
  //   } else {
  //     try {
  //       WordPressError err = WordPressError.fromJson(json.decode(response.body));
  //       throw err;
  //     } catch (e) {
  //       throw new WordPressError(message: response.body);
  //     }
  //   }
  // }

  // async.Future<Post> createPost({@required Post post}) async {
  //   final StringBuffer url = new StringBuffer(_baseUrl + URL_POSTS);
  //   String adminName = 'hunter';
  //   String adminKey = "g#D7\$D\$&%*!dbyvv^l5Wn&Y8";
  //   String str = '$adminName:$adminKey';
  //   String base64 = base64Encode(utf8.encode(str));
  //   Map<String, String> _urlHeader = {
  //     'Authorization': 'Basic $base64',
  //   };

  //   final response = await http.post(
  //     Uri.parse('$url'),
  //     headers: _urlHeader,
  //     body: post.toJson(),
  //   );

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return Post.fromJson(json.decode(response.body));
  //   } else {
  //     try {
  //       WordPressError err = WordPressError.fromJson(json.decode(response.body));
  //       throw err;
  //     } catch (e) {
  //       throw new WordPressError(message: response.body);
  //     }
  //   }
  // }
  async.Future<List<Category>> fetchCategories(
      {@required ParamsCategoryList params, bool fetchAll = false}) async {
    if (fetchAll) {
      params = params.copyWith(perPage: 100);
    }

    final StringBuffer url = StringBuffer(_baseUrl + URL_CATEGORIES);

    url.write(params.toString());

    final _route = '$url' + CATEGORY_FIELDS;

    // debugPrint('\n\n\n$_route\n\n\n');

    final response = await http.get(
      Uri.parse(_route),
      // headers: _urlHeader,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<Category> categories = <Category>[];
      final list = json.decode(response.body);

      list.forEach((category) {
        categories.add(Category.fromJson(category));
      });

      if (fetchAll && response.headers["x-wp-totalpages"] != null) {
        final totalPages = int.parse(response.headers["x-wp-totalpages"]);

        for (int i = params.pageNum + 1; i <= totalPages; ++i) {
          categories.addAll(await fetchCategories(params: params.copyWith(pageNum: i)));
        }
      }

      return categories;
    } else {
      try {
        WordPressError err = WordPressError.fromJson(json.decode(response.body));
        throw err;
      } catch (e) {
        throw WordPressError(message: response.body);
      }
    }
  }

  /// This returns a list of [Tag] based on the filter parameters
  /// specified through [ParamsTagList] object. By default it returns only
  /// [ParamsTagList.perPage] number of tags in page [ParamsTagList.pageNum].
  ///
  /// In case of an error, a [WordPressError] object is thrown.
  async.Future<List<Tag>> fetchTags({@required ParamsTagList params}) async {
    final StringBuffer url = StringBuffer(_baseUrl + URL_TAGS);

    url.write(params.toString());

    final _route = '$url' + TAG_FIELDS;

    // debugPrint('\n\n\n$_route\n\n\n');

    final response = await http.get(
      Uri.parse(_route.toString()),
      // headers: _urlHeader,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<Tag> tags = <Tag>[];
      final list = json.decode(response.body);
      list.forEach((tag) {
        tags.add(Tag.fromJson(tag));
      });
      return tags;
    } else {
      try {
        WordPressError err = WordPressError.fromJson(json.decode(response.body));
        throw err;
      } catch (e) {
        throw WordPressError(message: response.body);
      }
    }
  }
}
