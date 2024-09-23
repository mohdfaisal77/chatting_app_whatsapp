import 'package:chatting_app/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});




  @override
  Widget build(BuildContext context) {
    SplashController splashController=Get.put(SplashController());
    return  Scaffold(
      body:Center(
        child: Text("InfoSphere"),
      )
    );
  }
}
