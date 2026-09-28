import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstants {
  const EnvConstants._();

  static String get supabaseUrl => _required('SUPABASE_URL');

  static String get supabasePublishableKey =>
      _required('SUPABASE_PUBLISHABLE_KEY');

  static String get gNewsApiKey =>
      _required('GNEWS_API_KEY');

  static String get googleIosClientId =>
      _required('GOOGLE_IOS_CLIENT_ID');

  static String get googleWebClientId =>
      _required('GOOGLE_WEB_CLIENT_ID');

  static String _required(String key) {
    final value = dotenv.env[key];

    if (value == null || value.trim().isEmpty) {
      throw StateError('$key is missing from the .env file.');
    }

    return value;
  }
}