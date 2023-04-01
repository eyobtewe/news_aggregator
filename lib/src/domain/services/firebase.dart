import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import '../schemas/schema.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference postsColl = firestore.collection('posts');
final CollectionReference sourcesColl = firestore.collection('sources');
QueryDocumentSnapshot queryDocumentSnapshot;

class FirebaseService {
  Client client = Client();

  Future<List<Post>> getPosts({NewsSource source, String term, Map id}) async {
    try {
      if (id != null) {
        return await getSinglePost(id);
      } else if (source != null) {
        return await getSourcedPosts(source);
      } else {
        return await getAllPosts();
      }
    } on FirebaseException catch (e) {
      debugPrint('\n\n\n$e\n\n\n');
      return null;
    }
  }

  Future<List<Post>> getAllPosts() async {
    Query<Map> query = queryDocumentSnapshot != null
        ? postsColl
            .limit(20)
            .where('status', isEqualTo: 'PostStatus.published')
            .orderBy("timestamp", descending: true)
            .startAfterDocument(queryDocumentSnapshot)
        : postsColl
            .where('status', isEqualTo: 'PostStatus.published')
            .limit(20)
            .orderBy("timestamp", descending: true);

    return await query?.snapshots()?.first?.then(
      (QuerySnapshot<Map> ee) {
        if (ee.docs.isEmpty) return [];

        queryDocumentSnapshot = ee.docs.last;

        return ee.docs.map((e) {
          return Post.fromJson(e.data());
        }).toList();
      },
    );
  }

  Future<List<Post>> getSourcedPosts(NewsSource source) async {
    return await firestore
        .collection('posts')
        .where('source', isEqualTo: source.name)
        .where('status', isEqualTo: 'PostStatus.published')
        .orderBy("timestamp", descending: true)
        .limit(25)
        .get()
        .then(
      (QuerySnapshot<Map> value) {
        return value.docs.map(
          (e) {
            return Post.fromJson(e.data());
          },
        ).toList();
      },
    );
  }

  Future<List<Post>> getSinglePost(Map<dynamic, dynamic> id) async {
    return await firestore
        .collection('posts')
        .where('source', isEqualTo: id.keys.first)
        .where('id', isEqualTo: int.parse(id.values.first))
        .get()
        .then(
      (QuerySnapshot<Map> value) {
        return value.docs.map(
          (QueryDocumentSnapshot<Map> e) {
            return Post.fromJson(e.data());
          },
        ).toList();
      },
    );
  }
  
  Future<List<Post>> search(String query) async {
    return await firestore
        .collection('posts')
        .where('title.rendered',isGreaterThanOrEqualTo: query)
        .get()
        .then(
      (QuerySnapshot<Map> value) {
        return value.docs.map(
          (QueryDocumentSnapshot<Map> e) {
            return Post.fromJson(e.data());
          },
        ).toList();
      },
    );
  }

  Future<List<NewsSource>> getNewsSources() async {
    try {
      return await sourcesColl.get().then(
        (value) {
          return value.docs.map(
            (QueryDocumentSnapshot e) {
              return NewsSource.fromJson(e.data());
            },
          ).toList();
        },
      );
    } on FirebaseException catch (e) {
      debugPrint('\n\n\n$e\n\n\n');
      return null;
    }
  }
}

class FetchDataException implements Exception {
  final String _message;
  final int _code;

  FetchDataException(this._message, this._code);

  @override
  String toString() {
    return "\n\n\t\tException: $_message/$_code\n\n";
  }

  int code() {
    return _code;
  }
}
