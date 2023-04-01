library time_ago_provider;

import '../core/core.dart';

class TimeAgo {
  // static const int SECOND_MILLIS = 1000;
  static const int minute = 60 * 1000;
  static const int hour = 60 * minute;
  static const int day = 24 * hour;
  static const int month = 30 * day;
  static const int year = 12 * month;

  static String getTimeAgo(int timeStamp, {String language}) {
    assert(timeStamp != null,
        "Parameter timeStamp must not be null: TimeAgo.getTimeAgo(YOUR_TIME_STAMP)");
    language = language ?? 'tg';

    if (timeStamp < 1000000000000) {
      timeStamp *= 1000;
    }

    int now = DateTime.now().millisecondsSinceEpoch;
    if (timeStamp > now || timeStamp <= 0) {
      switch (language) {
        case 'all':
        case 'en':
          return "just now";
        case 'tg':
          return "ሐዚ ዝወፀ";
        case 'am':
          return "አዲስ";

        default:
          return "";
      }
    }

    final int difference = now - timeStamp;
    if (difference < minute) {
      switch (language) {
        case 'all':
        case 'en':
          return "just now";
        case 'tg':
          return "ሐዚ ዝወፀ";
        case 'am':
          return "አዲስ";

        default:
          return "";
      }
    } else if (difference < 2 * minute) {
      switch (language) {
        case 'all':
        case 'en':
          return "a minute ago";
        case 'tg':
          return "ቅድሚ ደቓይቕ";
        case 'am':
          return "ከጥቂት ድቂቆች በፊት";

        default:
          return "";
      }
    } else if (difference < 50 * minute) {
      switch (language) {
        case 'all':
        case 'en':
          return "${(difference / minute).toString().split(".")[0]}m ago";
        case 'tg':
          return "ቅድሚ ${(difference / minute).toString().split(".")[0]} ደቓይቕ";
        case 'am':
          return "ከ${(difference / minute).toString().split(".")[0]} ድቂቆች በፊት";

        default:
          return "";
      }
    } else if (difference < 90 * minute) {
      switch (language) {
        case 'all':
        case 'en':
          return "an hour ago";
        case 'tg':
          return "ቅድሚ 1 ሰዓት";
        case 'am':
          return "ከ1 ስዐት በፊት";

        default:
          return "";
      }
    } else if (difference < 24 * hour) {
      switch (language) {
        case 'all':
        case 'en':
          return "${(difference / hour).toString().split(".")[0]} hours ago";
        case 'tg':
          return "ቅድሚ ${(difference / hour).toString().split(".")[0]} ሰዓት";
        case 'am':
          return "ከ${(difference / hour).toString().split(".")[0]} ሰዐት በፊት";

        default:
          return "";
      }
    } else if (difference < 48 * hour) {
      switch (language) {
        case 'all':
        case 'en':
          return "Yesterday";
        case 'tg':
          return "ትማሊ";
        case 'am':
          return "ትናንት";

        default:
          return "";
      }
    } else if (difference < 7 * day) {
      switch (language) {
        case 'all':
        case 'en':
          return "${(difference / day).toString().split(".")[0]} days ago";
        case 'tg':
          return "ቅድሚ ${(difference / day).toString().split(".")[0]} መዓልቲ";
        case 'am':
          return "ከ${(difference / day).toString().split(".")[0]} ቀናት በፊት";

        default:
          return "";
      }
      // } else if (difference < 12 * month) {
      //   switch (language) {
      //     case 'all':
      //     case 'en':
      //       return (difference / month < 2)
      //           ? "a month ago"
      //           : "${(difference / month).toString().split(".")[0]} months ago";
      //     case 'tg':
      //       return (difference / month < 2)
      //           ? "ቅድሚ ወርሒ"
      //           : "ቅድሚ ${(difference / month).toString().split(".")[0]} ኣዋርሕ";
      //     case 'am':
      //       return (difference / month < 2)
      //           ? "ከአንድ ወር በፊት"
      //           : "ከ${(difference / month).toString().split(".")[0]} ወራት በፊት";

      //     default:
      //       return "";
      //   }
    } else {
      DateTime d = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      String mon;
      switch (language) {
        case 'all':
        case 'en':
          mon = Months.english[d.month - 1];
          return "${d.day} $mon";

        case 'am':
          mon = Months.amharic[d.month - 1];
          return "$mon ${d.day}";
        case 'tg':
          mon = Months.tigrigna[d.month - 1];
          return "$mon ${d.day}";
        default:
          return "";
      }
    }
  }
}

/// Supported Languages (Locals)
