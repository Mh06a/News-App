import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/hive_manager.dart';
import 'package:news_app/core/themes/light_theme.dart';
import 'package:news_app/features/splash/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();

  // Initialize Hive (user & bookmarks storage)
  await HiveManager().init();

  //PreferencesManager().clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
