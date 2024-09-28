import 'dart:io';

import 'package:chatting_app/controller/chat_controller.dart';
import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/models/chat_model.dart';
import 'package:chatting_app/models/user_model.dart';
import 'package:chatting_app/widgets/send_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../config/images.dart';
import '../../widgets/chat_bubble.dart';
import '../profile/users_profile_screen.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;

  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(

        appBar: AppBar(

          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.to(UsersProfileScreen(userModel: userModel,));
            },
            child: Padding(

              padding: EdgeInsets.all(5),
              child: Container(
                // width:50,
                // height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(AssetsImages.boyPic),),

                // Profile Image of other users........................

                //   child: Image.network(userModel.profileImage ?? AssetsImages.defaultProfileUrl,fit: BoxFit.cover,),
                // )
              ),

              //
            ),
          ),

// leading: IconButton (onPressed: ()

// {), icon: Icon(Icons.arrow_back_icon_new),

          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.to(UsersProfileScreen(userModel: userModel));
            },
            child: Row(
              children: [
                Column(
                  children: [
                    Text(userModel.name ?? "User", style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge),
                    Text("Online", style: Theme
                        .of(context)
                        .textTheme
                        .labelSmall),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.phone)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.video_call)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SendMessage(userModel: userModel),
        body: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 70, left: 10, right: 10),

            child: Column(
                children: [
            Expanded(
            child: Stack(
            children: [


                StreamBuilder<List<ChatModel>>(
                stream: chatController.getMessages(userModel.id!),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(

                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(

                  child: Text("Error: ${snapshot.error}"),);
              }

              if (snapshot.data == null) {
                return Center(child: Text("No Message"),);
              }

              else {
                return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      DateTime timestamp =
                      DateTime.parse(snapshot.data![index].timestamp!);
                      String formattedTime = DateFormat('hh:mm a').format(
                          timestamp);
                      return ChatBubble(
                        message: snapshot.data! [index].message!,
                        // imageUrl: AssetsImages.defaultProfileUrl,
                        imageUrl: snapshot.data![index].imageUrl ?? "",
                        isComming: snapshot.data![index].senderId !=
                            profileController.currentUser.value.id,
                        status: "read",
                        time: formattedTime,
                      );
                    }
                );
              }
            }
        ),
        Obx(() => (chatController.selectedImagePath.value != " ") ?
        Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(
                File(chatController.selectedImagePath.value)
              ),
              fit: BoxFit.contain
            ),
              color: Theme
                  .of(context)
                  .colorScheme
                  .primaryContainer,
              borderRadius: BorderRadius.circular(15)
          ),
          height: 500,
        ),
        ):Container(),
        )


    ],
    ),

    ),
    ],
    )
    )
    );
  }
}






