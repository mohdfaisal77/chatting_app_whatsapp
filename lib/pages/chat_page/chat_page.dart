import 'package:chatting_app/controller/chat_controller.dart';
import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/models/chat_model.dart';
import 'package:chatting_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    ProfileController profileController=Get.put(ProfileController());
    return Scaffold(

        appBar: AppBar(

          leading: InkWell(
            onTap: (){
              Get.to(UsersProfileScreen(userModel: userModel,));
            },
            child: Padding(

              padding: EdgeInsets.only(left: 10),


              child: Image.asset(AssetsImages.boyPic),),
          ),

// leading: IconButton (onPressed: ()

// {), icon: Icon(Icons.arrow_back_icon_new),
          title: InkWell(
            onTap: (){
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
                  ],),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.phone)), IconButton(
                onPressed: () {}, icon: Icon(Icons.video_call)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Theme
              .of(context)
              .colorScheme
              .primaryContainer),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                child: Icon(Icons.mic, size: 25),),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        filled: false,
                        hintText: "Type message.... ")
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 30,
                width: 30,
                child: Icon(Icons.photo_sharp, size: 25),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  // var newChat = ChatModel(
                  //
                  // ) ;

                  if (messageController.text.isNotEmpty) {
                    chatController.sendMessage(
                        userModel.id!, messageController.text,userModel);
                    messageController.clear();
                  }
                },
                child: Container(height: 30,
                    width: 30,
                    child: Icon(Icons.send, size: 25)),
              ),
            ],),),
        body: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 70, left: 10, right: 10),

            child: StreamBuilder<List<ChatModel>>(
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
                          DateTime timestamp=
                             DateTime.parse( snapshot.data![index].timestamp!);
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
                  }          }
            )
        )
    );
  }
}




