import 'package:chatting_app/config/page_path.dart';
import 'package:chatting_app/config/strings.dart';
import 'package:chatting_app/config/themes.dart';
import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/pages/auth/register_screen.dart';
import 'package:chatting_app/pages/profile/profile_screen.dart';
import 'package:chatting_app/pages/splash_page/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:chatting_app/pages/auth/login_screen.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/profile_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: pagePath,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: LoginScreen(),
    );
  }
}
//Changes in Rules of Storage needed to be performed for sending and downloading the images.


//CHat controller .

//import 'package:chatting_app/controller/profile_controller.dart';
// import 'package:chatting_app/models/chat_room_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';
//
// import '../models/chat_model.dart';
// import '../models/user_model.dart';
//
// class ChatController extends GetxController {
//   final auth = FirebaseAuth.instance;
// RxString selectedImagePath = " ".obs;
//   final storage = GetStorage();
//
//   ProfileController controller = Get.put(ProfileController());
//
//   final db = FirebaseFirestore.instance;
//
//   RxBool isLoading = false.obs;
//
//   var uuid = Uuid();
//
//   String getRoomId(String targetUserId) {
//     String currentUserId = auth.currentUser!.uid;
//
//     if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
//       return currentUserId + targetUserId;
//     } else {
//       return targetUserId + currentUserId;
//     }
//   }
//
//   UserModel getSender(UserModel currentUser, UserModel targetUser){
//     String currentUserId=currentUser.id!;
//     String targetUserId = targetUser.id!;
//     if(currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
//       return currentUser;
//     }else{
//       return targetUser;
//     }
//   }
//
//   UserModel getReceiver(UserModel currentUser, UserModel targetUser){
//     String currentUserId=currentUser.id!;
//     String targetUserId = targetUser.id!;
//     if(currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
//       return targetUser;
//     }else{
//       return currentUser;
//     }
//   }
//
//   Future<void> sendMessage(String targetUserId, String message,UserModel targetUser) async {
//     isLoading.value = true;
//     String chatId = uuid.v6();
//     String roomId = getRoomId(targetUserId);
//     DateTime timestamp=
//     DateTime.now();
//     String nowTime = DateFormat('hh:mm a').format(
//         timestamp);
//
// UserModel sender = getSender(controller.currentUser.value, targetUser);
// UserModel receiver = getReceiver(controller.currentUser.value, targetUser);
//
// RxString imageUrl = "".obs;
//
// if(selectedImagePath.value.isNotEmpty){
//   imageUrl.value=await controller.uploadFileToFirebase(selectedImagePath.value);
// }
//
//     var newChat = ChatModel(
//       id: chatId,
//       message: message,
//       imageUrl: imageUrl.value,
//       senderId: auth.currentUser!.uid,
//       receiverId: targetUserId,
//       senderName: controller.currentUser.value.name,
//       timestamp: DateTime.now().toString(),
//     );
//     // var receiver=UserModel(
//     //   id:controller.currentUser.value.id,
//     //   name: controller.currentUser.value.name,
//     //   profileImage: controller.currentUser.value.profileImage,
//     //   email: controller.currentUser.value.email,
//     // );
//     var roomDetails = ChatRoomModel(
//       id: roomId,
//       lastMessage: message,
//       lastMessageTimestamp: nowTime,
//       sender: sender,
//       receiver: receiver,
//       timestamp: DateTime.now().toString(),
//       unReadMessNo: 0
//     );
// //Need of Firestore to create collection and store data in that collection.
//     try {
//       await db.collection("chats")
//           .doc(roomId)
//           .collection("messages")
//           .doc(chatId)
//           .set(
//         newChat.toJson(),
//       );
// selectedImagePath.value =" ";
//      await db.collection("chats")
//           .doc(roomId)
//           .set(
//         roomDetails.toJson(),
//       );
//
//
//     } catch (e) {
//       print(e);
//     }
//     isLoading.value = false;
//   }
//
//   Stream<List<ChatModel>> getMessages(String targetUserId) {
//     String roomId = getRoomId(targetUserId);
//
//     return db
//         .collection("chats")
//         .doc(roomId) // Assuming roomId corresponds to a specific chat document
//         .collection("messages") // Accessing the sub-collection of messages
//         .orderBy("timestamp", descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => ChatModel.fromJson(doc.data()))
//             .toList());
//   }
// }
// //pVf7g0Otq6Pl9siBC49GhOq0e4139LbsFAV6pmc13zSjTuUC3gatq9u2


//For Cached Image.

// ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child:CachedNetworkImage(imageUrl: imageUrl,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context,url)=>CircularProgressIndicator(),
//
//                               ),
//                           ),