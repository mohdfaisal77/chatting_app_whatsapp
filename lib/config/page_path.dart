import 'package:chatting_app/pages/auth/login_screen.dart';
import 'package:chatting_app/pages/auth/register_screen.dart';
import 'package:chatting_app/pages/contact_page/contact_page.dart';
import 'package:chatting_app/pages/home/home_screen.dart';
import 'package:chatting_app/pages/profile/profile_screen.dart';
import 'package:chatting_app/widgets/bottom_navbar.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/chat_page/chat_page.dart';

var pagePath = [
  GetPage(
    name: "/register_screen",
    page: () => RegisterScreen(),
    transition: Transition.leftToRight
  ),
  GetPage(
      name: "/bottom_navbar",
      page: () => BottomNav(),
      transition: Transition.leftToRight
  ),
  GetPage(
      name: "/login_screen",
      page: () => LoginScreen(),
      transition: Transition.leftToRight
  ),
  GetPage(
      name: "/home_screen",
      page: () => HomeScreen(),
      transition: Transition.leftToRight
  ),
  GetPage(
      name: "/contact_page",
      page: () => ContactPage(),
      transition: Transition.leftToRight
  ),
  // GetPage(
  //
  //   name:"/chat_page",
  //
  //   page: ()=> ChatPage(),
  //
  //   transition: Transition.rightToLeft,
  //
  // ),
  GetPage(

    name:"/profile_screen",

    page: ()=> ProfileScreen(),

    transition: Transition.rightToLeft,

  )
];
