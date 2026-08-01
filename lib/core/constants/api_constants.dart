class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl = 'https://newsapi.org/v2';

  // API Key
  static const String apiKey = 'd6111c221c924249a2a11e966db065e4';

  // Endpoints
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';

  static const String defaultCategory = "business";
  static const List<String> categories = [
    defaultCategory,
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];
}
