import 'dart:async';

import 'package:news_aggregator/src/domain/schemas/schema.dart';
import 'package:news_aggregator/src/domain/services/firebase.dart';

import '../domain/repository/repository.dart';

class ApisBloc {
  final _repository = Repository();

  List<Post> posts = [];
  List<NewsSource> newsSources = [];
  // List<Category> newsSources = [];

  Map<dynamic, List<Post>> sourceBasedPosts = {};
  // Map<String, List<Tag>> tags = {};
  List<Post> searchResults = [];

  // void sort() {
  //   if (posts.isNotEmpty) {
  //     posts.sort((b, a) {
  //       return a.date.compareTo(b.date);
  //     });
  //   }
  // }
  // Future<List<Post>> fetchPosts(
  //   int categories,
  //   int page,
  //   int count, {
  //   List<int> includePost,
  //   List<int> excludePosts,
  //   Tag tag,
  // }) async {
  //   List<Post> data = await _repository.fetchPosts(categories, page, count, tag: tag);
  //   if (categories != null) {
  //     sourceBasedPosts[categories] = data;
  //     return data;
  //   } else {
  //     if (page != 1) {
  //       if (data != null && data.isNotEmpty) {
  //         posts.addAll(data);
  //       }
  //     } else {
  //       posts = data;
  //     }
  //     return posts;
  //   }
  // }
  // Future<List<Tag>> fetchTags(Post post) async {
  //   List<Tag> data = await _repository.fetchTags(post);
  //   if (post == null) {
  //     tags['search'] = data;
  //   } else {
  //     tags['${post.id}'] = data;
  //   }
  //   return data;
  // }
  // Future<List<Post>> search(String term) async {
  //   return await _repository.search(term);
  // }
  // Future<List<Category>> fetchCategories({int parent}) async {
  //   newsSources = await _repository.fetchCategories();
  //   return newsSources;
  // }

  Future<List<Post>> getPosts({NewsSource source, String term, Map id}) async {
    List<Post> data =
        await _repository.getPosts(source: source, term: term, id: id);

    data.removeWhere((Post p) {
      return p.content.rendered == '';
    });

    if (source != null) sourceBasedPosts[source.name] = data;
    if (term != null) searchResults = data;
    if (source == null && term == null) {
      if (queryDocumentSnapshot != null) {
        if (data.isNotEmpty) posts.addAll(data);
      } else {
        posts = data;
      }

      // posts.toSet().toList().sort((b, a) {
      //   return a.date.compareTo(b.date);
      // });

      return posts;
    }

    return data;
  }

  Future<List<NewsSource>> getNewsSources() async {
    newsSources = await _repository.getNewsSources();
    return newsSources;
  }

  void clearData() {
    if (queryDocumentSnapshot != null) queryDocumentSnapshot = null;
    if (newsSources != null) newsSources.clear();
    if (posts != null) posts.clear();
  }

  Future<void> init() async {
    // fetchCategories();
    // fetchTags(null);
    // FirebaseService firebaseService = FirebaseService();
    // firebaseService.getAllPosts();

    getPosts();
    getNewsSources();
  }
}
