import 'package:chatting_app/controller/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../controller/chat_controller.dart';
import '../models/user_model.dart';
import 'image_picker_bottom_sheet.dart';
class SendMessage extends StatelessWidget {
  final UserModel userModel;

  const SendMessage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    ImagePickerController imagePickerController = Get.put(
        ImagePickerController());
    return Container(
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
            child: Icon(Icons.emoji_emotions_outlined, size: 25),
          ),
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
          Obx(() =>
          chatController.selectedImagePath.value == " " ?
          InkWell(
            onTap: () {
              // chatController.selectedImagePath.value =
              // await imagePickerController.pickImage();
              ImagePickerBottomSheet(
                  context, chatController, imagePickerController);
            },
            child: Container(
              height: 30,
              width: 30,
              child: Icon(Icons.photo_sharp, size: 25),
            ),
          ) : InkWell(
            onTap: () async {
              chatController.selectedImagePath.value = " ";
            },
            child: Container(
              height: 30,
              width: 30,
              child: Icon(Icons.close, size: 25),
            ),)
          ),
          SizedBox(width: 10),
          InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                // var newChat = ChatModel(
                //
                // ) ;
                if (messageController.text.isNotEmpty ||
                    chatController.selectedImagePath.value.isNotEmpty) {
                  chatController.sendMessage(
                      userModel.id!, messageController.text, userModel);
                  messageController.clear();
                }
              },
              child: Obx(() =>
                  Container(height: 30,
                      width: 30,
                      child: chatController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.send, size: 25)),)
          ),
        ],),);
  }
}
