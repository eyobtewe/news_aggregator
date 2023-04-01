import '../constants.dart';

/// This class holds all arguments which can be used to filter Categories when using
/// [WordPress.fetchCategories] method.
///
/// [List Categories' Arguments](https://developer.wordpress.org/rest-api/reference/categories/#list-categories)
class ParamsCategoryList {
  final WordPressContext context;
  final int pageNum;
  final int perPage;
  final String searchQuery;
  final List<int> excludeCategoryIDs;
  final List<int> includeCategoryIDs;
  final Order order;
  final CategoryTagOrderBy orderBy;
  final bool hideEmpty;
  final int parent;
  final int post;
  final String slug;

  ParamsCategoryList({
    this.context = WordPressContext.view,
    this.pageNum = 1,
    this.perPage = 10,
    this.searchQuery = '',
    this.excludeCategoryIDs,
    this.includeCategoryIDs,
    this.order = Order.asc,
    this.orderBy = CategoryTagOrderBy.name,
    this.hideEmpty,
    this.parent,
    this.post,
    this.slug = '',
  });

  Map<String, String> toMap() {
    return {
      'context': enumStringToName(context.toString()),
      'page': '$pageNum',
      'per_page': '$perPage',
      'search': searchQuery,
      'exclude': listToUrlString(excludeCategoryIDs),
      'include': listToUrlString(includeCategoryIDs),
      'order': enumStringToName(order.toString()),
      'orderby': enumStringToName(orderBy.toString()),
      'hide_empty': '${hideEmpty ?? ''}',
      'parent': '${parent ?? ''}',
      'post': '${post ?? ''}',
      'slug': slug,
    };
  }

  ParamsCategoryList copyWith({int pageNum, int perPage}) {
    return ParamsCategoryList(
        context: context,
        order: order,
        orderBy: orderBy,
        pageNum: pageNum ?? this.pageNum,
        perPage: perPage ?? this.perPage,
        searchQuery: searchQuery,
        slug: slug,
        excludeCategoryIDs: excludeCategoryIDs,
        hideEmpty: hideEmpty,
        includeCategoryIDs: includeCategoryIDs,
        parent: parent,
        post: post);
  }

  @override
  String toString() {
    return constructUrlParams(toMap(), CATEGORY_FIELDS);
  }
}
