import 'package:chatting_app/config/images.dart';
import 'package:chatting_app/controller/chat_controller.dart';
import 'package:chatting_app/controller/contact_controller.dart';
import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/pages/chat_page/chat_page.dart';
import 'package:chatting_app/widgets/contact_search.dart';
import 'package:chatting_app/widgets/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/chat_list.dart';
class ContactPage extends StatelessWidget {

  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable =false.obs;
    ProfileController profileController=Get.put(ProfileController());
    ChatController chatController=Get.put(ChatController());
    ContactController contactController=Get.put(ContactController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Contact"),
        actions: [
          Obx(() => IconButton(onPressed: (){

            isSearchEnable.value=!isSearchEnable.value;
          }, icon:isSearchEnable.value ? Icon(Icons.close) :  Icon(Icons.search)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [

           Obx(() => isSearchEnable.value ?  ContactSearch() : SizedBox(),),

            SizedBox(height: 10,),
        NewContact(btnName: "New Contact", icon: Icons.person_add, ontap: (){

        }),
            SizedBox(height: 10,),Row(
              children: [

                Text("Contacts on Chat App")
              ],
            ),
            Column(
              children: contactController.userList.map((e) =>InkWell(
                onTap: (){
                // Get.to("/chat_page");
                  Get.to(ChatPage(userModel:e));
                  String roomId=chatController.getRoomId(e.id!);
                  print(roomId);
                },
                child: ChatTile(imageUrl:e.profileImage ??   AssetsImages.defaultProfileUrl, name: e.name ?? "User", lastChat:e.bio ?? "Hey there",
                  lastTime:e.email == profileController.auth.currentUser!.email! ? "You" : "",

                ),
              ),
              ).toList(),
            )

          ],
        ),
      ),
    );
  }
}
