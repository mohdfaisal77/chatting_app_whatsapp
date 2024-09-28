import 'package:chatting_app/controller/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/chat_controller.dart';


Future<dynamic> ImagePickerBottomSheet(BuildContext context, ChatController chatController, ImagePickerController imagePickerController) {
  return Get.bottomSheet(
      Container(
        height: 100,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap:()async{
                chatController.selectedImagePath.value =
                await imagePickerController.pickImage(ImageSource.camera);
                Get.back();
              },
              child: Container(
                height:70,
                width: 70,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Icon(Icons.photo_sharp,size: 30,),
              ),
            ),
            InkWell(
              onTap:()async{
                chatController.selectedImagePath.value =
                await imagePickerController.pickImage(ImageSource.gallery);
                Get.back();
              },
              child: Container(
                height:70,
                width: 70,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Icon(Icons.photo_sharp,size: 30,),
              ),
            ),
            InkWell(
              onTap:(){
              },
              child: Container(
                height:70,
                width: 70,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Icon(Icons.play_arrow,size: 30,),
              ),
            ),
          ],
        ),
      )
  );
}
