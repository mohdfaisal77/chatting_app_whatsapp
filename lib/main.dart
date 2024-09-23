import 'package:chatting_app/config/page_path.dart';
import 'package:chatting_app/config/strings.dart';
import 'package:chatting_app/config/themes.dart';
import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/pages/auth/register_screen.dart';
import 'package:chatting_app/pages/profile/profile_screen.dart';
import 'package:chatting_app/pages/splash_page/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:chatting_app/pages/auth/login_screen.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/profile_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: pagePath,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: LoginScreen(),
    );
  }
}

