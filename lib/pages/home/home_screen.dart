import 'package:chatting_app/config/strings.dart';
import 'package:chatting_app/controller/auth_controller.dart';
import 'package:chatting_app/controller/image_picker_controller.dart';
import 'package:chatting_app/widgets/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../config/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ImagePickerController imagePickerController= Get.put(ImagePickerController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        // leading: ,
        actions: [
          IconButton(onPressed: () {
            authController.logOutUser();
            
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            Get.toNamed("/profile_screen");

          }, icon: Icon(Icons.more_vert))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        children: [
          InkWell(
            onTap: () {
              Get.toNamed("/chat_page");
            },
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Faisal',
              lastChat: 'Ruko',
              lastTime: '09:39PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
          InkWell(
            onTap: () {},
            child: ChatTile(
              imageUrl: AssetsImages.defaultProfileUrl,
              name: 'Sadaf',
              lastChat: 'Kiyo',
              lastTime: '09:40PM',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/contact_page');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add),
      ),
    );
  }
}
