import '../constants.dart';

/// This class holds all arguments which can be used to filter media when using
/// [WordPress.fetchMediaList] method.
///
/// [List Media Arguments](https://developer.wordpress.org/rest-api/reference/media/#list-media)
class ParamsMediaList {
  final WordPressContext context;
  final int pageNum;
  final int perPage;
  final String searchQuery;
  final String afterDate;
  final List<int> includeAuthorIDs;
  final List<int> excludeAuthorIDs;
  final String beforeDate;
  final List<int> excludeMediaIDs;
  final List<int> includeMediaIDs;
  final int offset;
  final Order order;
  final MediaOrderBy orderBy;
  final List<int> includeParentIDs;
  final List<int> excludeParentIDs;
  final String slug;
  final MediaStatus mediaStatus;
  final MediaType mediaType;
  final String mimeType;

  ParamsMediaList({
    this.context = WordPressContext.view,
    this.pageNum = 1,
    this.perPage = 10,
    this.searchQuery = '',
    this.afterDate = '',
    this.includeAuthorIDs,
    this.excludeAuthorIDs,
    this.beforeDate = '',
    this.excludeMediaIDs,
    this.includeMediaIDs,
    this.offset,
    this.order = Order.desc,
    this.orderBy = MediaOrderBy.date,
    this.excludeParentIDs,
    this.includeParentIDs,
    this.slug = '',
    this.mediaStatus = MediaStatus.inherit,
    this.mediaType,
    this.mimeType = '',
  });

  Map<String, String> toMap() {
    return {
      'context': enumStringToName(context.toString()),
      'page': '$pageNum',
      'per_page': '$perPage',
      'search': searchQuery,
      'after': afterDate,
      'author': listToUrlString(includeAuthorIDs),
      'author_exclude': listToUrlString(excludeAuthorIDs),
      'before': beforeDate,
      'exclude': listToUrlString(excludeMediaIDs),
      'include': listToUrlString(includeMediaIDs),
      'offset': '${offset ?? ''}',
      'order': enumStringToName(order.toString()),
      'orderby': enumStringToName(orderBy.toString()),
      'parent': listToUrlString(includeParentIDs),
      'parent_exclude': listToUrlString(excludeParentIDs),
      'slug': slug,
      'status': enumStringToName(mediaStatus.toString()),
      'media_type':
          mediaType == null ? '' : enumStringToName(mediaType.toString()),
      'mime_type': mimeType,
    };
  }

  @override
  String toString() {
    return constructUrlParams(toMap(), MEDIA_FIELDS);
  }
}
