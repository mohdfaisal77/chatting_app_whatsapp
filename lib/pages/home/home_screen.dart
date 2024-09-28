import 'package:chatting_app/config/strings.dart';
import 'package:chatting_app/controller/auth_controller.dart';
import 'package:chatting_app/controller/contact_controller.dart';
import 'package:chatting_app/controller/image_picker_controller.dart';
import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/pages/chat_page/chat_page.dart';
import 'package:chatting_app/widgets/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../config/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ImagePickerController imagePickerController= Get.put(ImagePickerController());
    ContactController contactController=Get.put(ContactController());
    ProfileController profileController= Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        // leading: ,
        actions: [
          IconButton(onPressed: () {
            contactController.getChatRoomList();

          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            Get.toNamed("/profile_screen");

          }, icon: Icon(Icons.more_vert))
        ],
      ),
      body: RefreshIndicator(child: Obx(() => ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          children:contactController.chatRoomList.map((e) =>
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.to(ChatPage(userModel: (e.receiver!.id ==profileController.currentUser.value.id ? e.sender : e.receiver )!,),);
                },
                child: ChatTile(
                  imageUrl: (e.receiver!.id == profileController.currentUser.value.id ? e.sender!.profileImage : e.receiver!.profileImage) ?? AssetsImages.defaultProfileUrl,
                  name: (e.receiver!.id == profileController.currentUser.value.id ? e.sender!.name : e.receiver!.name)!,
                  lastChat: e.lastMessage ?? "Last Message",
                  lastTime: e.lastMessageTimestamp ?? '09:39PM',
                ),
              ),
          ).toList()
      ),), onRefresh: (){
        return contactController.getChatRoomList();
      }),
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
