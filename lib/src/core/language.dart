import 'core.dart';

class Language {
  static const Map<String, String> lEnglish = {
    'app_name': 'Everyday Ethiopia',
    rBookmarkPage: 'Bookmarks',
    rSourcesPage: 'Sources',
    'lightTheme': 'Light Theme',
    'sepiaTheme': 'Sepia Theme',
    'darkTheme': 'Dark Theme',
    'language': 'Language',
    'latest': 'Latest',
    'more': 'More',
    'try_again': 'Retry',
    'videos': 'Video',
    'news': 'Top Stories',
    'search': 'Search',
    'favorite': 'Bookmarks',
    'setting': 'More',
    'contact-us': 'Contact us',
    'about': 'About us',
    'review': 'Rate our App',
    'share': 'Share our App',
  };

  static const Map<String, String> lAmharic = {
    'app_name': 'Everyday Ethiopia',
    rBookmarkPage: 'Bookmarks',
    rSourcesPage: 'Sources',
    'lightTheme': 'ነጭ ሕብር',
    'sepiaTheme': 'Sepia Theme',
    'darkTheme': 'ጥቁር ሕብር',
    'language': 'ቋንቋ',
    'latest': 'ኣዳዲስ',
    'more': 'ተጨማሪ',
    'try_again': 'እንደገና ይሞክሩ',
    'videos': 'ቪድዮ',
    'news': 'ዜና',
    'search': 'ፈልግ',
    'favorite': 'ተወዳጅ',
    'setting': 'ቅንብር',
    'contact-us': 'አድራሻ',
    'about': 'ስለ እኛ ለማወቅ',
    'review': 'አስተያየት እንስጥ',
    'share': 'መተግበርያው እናጋራ',
  };
  static const Map<String, String> lTigrigna = {
    'app_name': 'Everyday Ethiopia',
    rBookmarkPage: 'Bookmarks',
    rSourcesPage: 'Sources',
    'lightTheme': 'ፃዕዳ ሕብሪ',
    'sepiaTheme': 'Sepia Theme',
    'darkTheme': 'ፀሊም ሕብሪ',
    'language': 'ቋንቋ',
    'latest': 'ሓደሽቲ',
    'more': 'ተወሰኽቲ',
    'try_again': 'ደጊሞም ይፈትኑ',
    'news': 'ዋና ገፅ',
    'search': 'ኣልሽ',
    'favorite': 'ዝተፈተዉ',
    'setting': 'ቕንብር',
    'contact-us': 'ኣድራሻና',
    'about': 'ብዛዕባና ንምፍላጥ',
    'review': 'ርኢቶ ንምሃብ',
    'share': 'ንኻልኦት ነካፍል',
  };

  static String locale(String lang, String key) {
    switch (lang) {
      case 'all':
      case 'en':
        return lEnglish[key];
      case 'am':
        return lAmharic[key];
      case 'tg':
        return lTigrigna[key];
      default:
        return lTigrigna[key];
    }
  }
}
