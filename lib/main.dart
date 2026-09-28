import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/constants/env_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/injection_container.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Hive.initFlutter();

  await Supabase.initialize(
    url: EnvConstants.supabaseUrl,
    publishableKey: EnvConstants.supabasePublishableKey,
  );

  await GoogleSignIn.instance.initialize(
    clientId: Platform.isIOS
        ? EnvConstants.googleIosClientId
        : null,
    serverClientId: EnvConstants.googleWebClientId,
  );

  await initDependencies();

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
        );
      },
    );
  }
}
