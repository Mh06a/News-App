import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:news_app/core/constants/env_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;
import 'package:news_app/Data/dataSource/local/local_settings_data_source.dart';
import 'package:news_app/Data/dataSource/local/news_cache_data_source.dart';
import 'package:news_app/Data/dataSource/local/recent_search_data_source.dart';
import 'package:news_app/Data/dataSource/remote/gnews_remote_data_source.dart';
import 'package:news_app/Data/dataSource/remote/supabase_auth_data_source.dart';
import 'package:news_app/Data/dataSource/remote/supabase_bookmark_data_source.dart';
import 'package:news_app/Data/dataSource/remote/supabase_storage_data_source.dart';
import 'package:news_app/Data/dataSource/remote/supabase_user_data_source.dart';
import 'package:news_app/Data/repositories/auth_repository_impl.dart';
import 'package:news_app/Data/repositories/bookmark_repository_impl.dart';
import 'package:news_app/Data/repositories/local_settings_repository_impl.dart';
import 'package:news_app/Data/repositories/news_repository_impl.dart';
import 'package:news_app/Data/repositories/recent_search_repository_impl.dart';
import 'package:news_app/Data/repositories/user_repository_impl.dart';
import 'package:news_app/Domain/repositories/auth_repository.dart';
import 'package:news_app/Domain/repositories/bookmark_repository.dart';
import 'package:news_app/Domain/repositories/local_settings_repository.dart';
import 'package:news_app/Domain/repositories/news_repository.dart';
import 'package:news_app/Domain/repositories/recent_search_repository.dart';
import 'package:news_app/Domain/repositories/user_repository.dart';
import 'package:news_app/Domain/usecases/auth/get_current_user.dart';
import 'package:news_app/Domain/usecases/auth/reset_password.dart';
import 'package:news_app/Domain/usecases/auth/sign_in.dart';
import 'package:news_app/Domain/usecases/auth/sign_in_with_apple.dart';
import 'package:news_app/Domain/usecases/auth/sign_in_with_google.dart';
import 'package:news_app/Domain/usecases/auth/sign_out.dart';
import 'package:news_app/Domain/usecases/auth/sign_up.dart';
import 'package:news_app/Domain/usecases/bookmark/add_bookmark.dart';
import 'package:news_app/Domain/usecases/bookmark/get_bookmarks.dart';
import 'package:news_app/Domain/usecases/bookmark/is_bookmarked.dart';
import 'package:news_app/Domain/usecases/bookmark/remove_bookmark.dart';
import 'package:news_app/Domain/usecases/news/get_news_by_category.dart';
import 'package:news_app/Domain/usecases/news/get_top_headlines.dart';
import 'package:news_app/Domain/usecases/news/search_news.dart';
import 'package:news_app/Domain/usecases/search/add_recent_search.dart';
import 'package:news_app/Domain/usecases/search/clear_recent_searches.dart';
import 'package:news_app/Domain/usecases/search/get_recent_searches.dart';
import 'package:news_app/Domain/usecases/search/remove_recent_search.dart';
import 'package:news_app/Domain/usecases/settings/get_breaking_news_enabled.dart';
import 'package:news_app/Domain/usecases/settings/get_news_country.dart';
import 'package:news_app/Domain/usecases/settings/get_news_language.dart';
import 'package:news_app/Domain/usecases/settings/is_onboarding_completed.dart';
import 'package:news_app/Domain/usecases/settings/set_breaking_news_enabled.dart';
import 'package:news_app/Domain/usecases/settings/set_news_country.dart';
import 'package:news_app/Domain/usecases/settings/set_news_language.dart';
import 'package:news_app/Domain/usecases/settings/set_onboarding_completed.dart';
import 'package:news_app/Domain/usecases/user/delete_account.dart';
import 'package:news_app/Domain/usecases/user/get_profile.dart';
import 'package:news_app/Domain/usecases/user/update_avatar.dart';
import 'package:news_app/Domain/usecases/user/update_profile.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/core/storage/local_storage.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ============================================================
  // External
  // ============================================================

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(
        () => sharedPreferences,
  );

  sl.registerLazySingleton<Connectivity>(
    Connectivity.new,
  );

  sl.registerLazySingleton<Dio>(
    DioClient.create,
  );

  sl.registerLazySingleton<SupabaseClient>(
        () => Supabase.instance.client,
  );

  // ============================================================
  // Core
  // ============================================================

  sl.registerLazySingleton<LocalStorage>(
        () => LocalStorage(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfo(sl<Connectivity>()),
  );

  // ============================================================
  // Local Data Sources
  // ============================================================

  sl.registerLazySingleton<LocalSettingsDataSource>(
        () => LocalSettingsDataSourceImpl(
      localStorage: sl<LocalStorage>(),
    ),
  );

  sl.registerLazySingleton<RecentSearchDataSource>(
        () => RecentSearchDataSourceImpl(
      localStorage: sl<LocalStorage>(),
    ),
  );

  final newsCacheBox = await Hive.openBox<dynamic>(
    'news_cache',
  );

  sl.registerLazySingleton<NewsCacheDataSource>(
        () => NewsCacheDataSourceImpl(
      box: newsCacheBox,
    ),
  );

  // ============================================================
  // Remote Data Sources
  // ============================================================

  sl.registerLazySingleton<GNewsRemoteDataSource>(
        () => GNewsRemoteDataSourceImpl(
      dio: sl<Dio>(),
      apiKey: EnvConstants.gNewsApiKey,
    ),
  );

  sl.registerLazySingleton<SupabaseAuthDataSource>(
        () => SupabaseAuthDataSourceImpl(
      supabaseClient: sl<SupabaseClient>(),
    ),
  );

  sl.registerLazySingleton<SupabaseBookmarkDataSource>(
        () => SupabaseBookmarkDataSourceImpl(
      supabase: sl<SupabaseClient>(),
    ),
  );

  sl.registerLazySingleton<SupabaseUserDataSource>(
        () => SupabaseUserDataSourceImpl(
      supabase: sl<SupabaseClient>(),
    ),
  );

  sl.registerLazySingleton<SupabaseStorageDataSource>(
        () => SupabaseStorageDataSourceImpl(
      supabase: sl<SupabaseClient>(),
    ),
  );

  // ============================================================
  // Repositories
  // ============================================================

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl<SupabaseAuthDataSource>(),
    ),
  );

  sl.registerLazySingleton<BookmarkRepository>(
        () => BookmarkRepositoryImpl(
      remoteDataSource: sl<SupabaseBookmarkDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<LocalSettingsRepository>(
        () => LocalSettingsRepositoryImpl(
      localDataSource: sl<LocalSettingsDataSource>(),
      cacheDataSource: sl<NewsCacheDataSource>(),
    ),
  );

  sl.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(
      remoteDataSource: sl<GNewsRemoteDataSource>(),
      cacheDataSource: sl<NewsCacheDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<RecentSearchRepository>(
        () => RecentSearchRepositoryImpl(
      localDataSource: sl<RecentSearchDataSource>(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
      userDataSource: sl<SupabaseUserDataSource>(),
      storageDataSource: sl<SupabaseStorageDataSource>(),
    ),
  );

  // ============================================================
  // Auth Use Cases
  // ============================================================

  sl.registerLazySingleton(
        () => GetCurrentUser(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => ResetPassword(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SignIn(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SignInWithApple(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SignInWithGoogle(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SignOut(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SignUp(
      sl<AuthRepository>(),
    ),
  );

  // ============================================================
  // Bookmark Use Cases
  // ============================================================

  sl.registerLazySingleton(
        () => AddBookmark(
      sl<BookmarkRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => GetBookmarks(
      sl<BookmarkRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => IsBookmarked(
      sl<BookmarkRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => RemoveBookmark(
      sl<BookmarkRepository>(),
    ),
  );

  // ============================================================
  // News Use Cases
  // ============================================================

  sl.registerLazySingleton(
        () => GetTopHeadlines(
      sl<NewsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => GetNewsByCategory(
      sl<NewsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SearchNews(
      sl<NewsRepository>(),
    ),
  );

  // ============================================================
  // Recent Search Use Cases
  // ============================================================

  sl.registerLazySingleton(
        () => AddRecentSearch(
      sl<RecentSearchRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => ClearRecentSearches(
      sl<RecentSearchRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => GetRecentSearches(
      sl<RecentSearchRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => RemoveRecentSearch(
      sl<RecentSearchRepository>(),
    ),
  );

  // ============================================================
  // Settings Use Cases
  // ============================================================

  sl.registerLazySingleton(
        () => GetBreakingNewsEnabled(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => GetNewsCountry(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => GetNewsLanguage(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => IsOnboardingCompleted(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SetBreakingNewsEnabled(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SetNewsCountry(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SetNewsLanguage(
      sl<LocalSettingsRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => SetOnboardingCompleted(
      sl<LocalSettingsRepository>(),
    ),
  );

  // ============================================================
  // User Use Cases
  // ============================================================

  sl.registerLazySingleton(
        () => DeleteAccount(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => GetProfile(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => UpdateAvatar(
      sl<UserRepository>(),
    ),
  );

  sl.registerLazySingleton(
        () => UpdateProfile(
      sl<UserRepository>(),
    ),
  );
}