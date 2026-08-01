class DateFormatter {
  //step1 -->> here I will Create a function to foram date :
  static String format(String? date) {
    if (date == null) return "";

    final diff = DateTime.now().difference(DateTime.parse(date));

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds}second ago";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}minute ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}hour ago";
    }

    return "${diff.inDays}day ago";
  }
}
