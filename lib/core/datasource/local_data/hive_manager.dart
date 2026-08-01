import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/bookmark/model/bookmark_adapter.dart';
import 'package:news_app/features/bookmark/model/bookmark_model.dart';
import 'package:news_app/features/user/model/user_model.dart';
import 'package:news_app/features/user/model/user_adapter.dart';
import 'package:news_app/core/datasource/local_data/storage_key.dart';

class HiveManager {
  HiveManager._internal();
  static final HiveManager _instance = HiveManager._internal();
  factory HiveManager() => _instance;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();
    //await Hive.deleteBoxFromDisk(StorageKey.userBox);
    //await Hive.deleteBoxFromDisk(StorageKey.bookmarkBox);

    // Register adapters (typeId values must remain stable)
    if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(BookmarkAdapter().typeId)) {
      Hive.registerAdapter(BookmarkAdapter());
    }

    // Open boxes using centralized names
    await Hive.openBox<UserModel>(StorageKey.userBox);
    await Hive.openBox<BookmarkModel>(StorageKey.bookmarkBox);

    _initialized = true;
  }

  Box<UserModel> get userBox => Hive.box<UserModel>(StorageKey.userBox);
  Box<BookmarkModel> get bookmarksBox =>
      Hive.box<BookmarkModel>(StorageKey.bookmarkBox);
}
