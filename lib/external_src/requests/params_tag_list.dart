import '../constants.dart';

/// This class holds all arguments which can be used to filter Tags when using
/// [WordPress.fetchTags] method.
///
/// [List Tags' Arguments](https://developer.wordpress.org/rest-api/reference/tags/#list-tags)
class ParamsTagList {
  final WordPressContext context;
  final int pageNum;
  final int perPage;
  final String searchQuery;
  final List<int> excludeTagIDs;
  final List<int> includeTagIDs;
  final Order order;
  final CategoryTagOrderBy orderBy;
  final bool hideEmpty;
  final int post;
  final String slug;

  ParamsTagList({
    this.context = WordPressContext.view,
    this.pageNum = 1,
    this.perPage = 10,
    this.searchQuery = '',
    this.excludeTagIDs,
    this.includeTagIDs,
    this.order = Order.asc,
    this.orderBy = CategoryTagOrderBy.name,
    this.hideEmpty,
    this.post,
    this.slug = '',
  });

  Map<String, String> toMap() {
    return {
      'context': enumStringToName(context.toString()),
      'page': '$pageNum',
      'per_page': '$perPage',
      'search': searchQuery,
      'exclude': listToUrlString(excludeTagIDs),
      'include': listToUrlString(includeTagIDs),
      'order': enumStringToName(order.toString()),
      'orderby': enumStringToName(orderBy.toString()),
      'hide_empty': '${hideEmpty ?? ''}',
      'post': '${post ?? ''}',
      'slug': slug,
    };
  }

  @override
  String toString() {
    return constructUrlParams(toMap(), TAG_FIELDS);
  }
}
