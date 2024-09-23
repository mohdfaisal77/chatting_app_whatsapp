import 'package:chatting_app/models/user_model.dart';
import 'package:chatting_app/pages/contact_page/contact_page.dart';
import 'package:chatting_app/pages/home/home_screen.dart';
import 'package:chatting_app/pages/profile/profile_screen.dart';
import 'package:chatting_app/pages/profile/users_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {

    final controller= Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>controller.selectedIndex.value = index,
          destinations: [
          NavigationDestination(icon: Icon(Icons.heart_broken_outlined), label: ""),
            NavigationDestination(icon: Icon(Icons.message_rounded), label: ""),
            NavigationDestination(icon: Icon(Icons.person_rounded), label: ""),
            NavigationDestination(icon: Icon(Icons.home_rounded), label: "")
        ],
        ),
      ),
      body:Obx(()=> controller.screens[controller.selectedIndex.value],),
    );
  }
}
class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [Container(),ContactPage(),ProfileScreen(),HomeScreen()];
}