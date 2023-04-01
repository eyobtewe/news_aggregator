import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '../schemas/schema.dart';

final kDynamicLinkService = DynamicLinkService();

class DynamicLinkService {
  Map<String, String> dynamicLinkDetected;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future handleDynamicLinks({Function(Map<String, String>) onLinkFound}) async {
    final PendingDynamicLinkData data = await dynamicLinks.getInitialLink();
    if (data != null) {
      dynamicLinkDetected = await _handleDynamicLink(data);
      onLinkFound(dynamicLinkDetected);
    }
    dynamicLinks.onLink.listen((PendingDynamicLinkData dynamicLinkData) async {
      dynamicLinkDetected = await _handleDynamicLink(dynamicLinkData);
      onLinkFound(dynamicLinkDetected);
    });
    // FirebaseDynamicLinks.instance.onLink(
    //   onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
    //     dynamicLinkDetected = await _handleDynamicLink(dynamicLinkData);
    //     onLinkFound(dynamicLinkDetected);
    //   },
    // );
  }

  Future<Map<String, String>> _handleDynamicLink(
      PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      return {
        deepLink.queryParameters['source']:
            deepLink.queryParameters['post'],
      };
    }
    return null;
  }

  Future<String> createDynamicLink(Post post, String lang) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://gazetas.page.link',
      link: Uri.parse(
          'https://gazetas.com/p?post=${post.id}&source=${post.source}'),
      androidParameters: AndroidParameters(
        packageName: 'io.media.news.aggregator',
        fallbackUrl: Uri.parse(post.link),
      ),

      // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      // ),
      // iosParameters: IosParameters(
      //   bundleId: 'io.media.news.aggregator',
      //   appStoreId: '123456789',
      //   fallbackUrl: Uri.parse(post.link),
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: post.title?.rendered ?? '',
        description: '',
        imageUrl: Uri.parse(post?.featuredMedia?.sourceUrl ?? ''),
      ),
    );
    // ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    // Uri shortUrl = shortDynamicLink.shortUrl;
    // return '$shortUrl';

    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    Uri url = shortLink.shortUrl;
    return '$url';
  }
}
