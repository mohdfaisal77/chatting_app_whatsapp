import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/chat_model.dart';
import '../models/user_model.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;

  final storage = GetStorage();

  ProfileController controller = Get.put(ProfileController());

  final db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  var uuid = Uuid();

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;

    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  Future<void> sendMessage(String targetUserId, String message,UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    var newChat = ChatModel(
      id: chatId,
      message: message,
      senderId: auth.currentUser!.uid,
      senderName: controller.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );
    // var receiver=UserModel(
    //   id:controller.currentUser.value.id,
    //   name: controller.currentUser.value.name,
    //   profileImage: controller.currentUser.value.profileImage,
    //   email: controller.currentUser.value.email,
    // );
    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: DateTime.now().toString(),

      sender: controller.currentUser.value,
      receiver: targetUser,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0
    );
//Need of Firestore to create collection and store data in that collection.
    try {

     await db.collection("chats")
          .doc(roomId)
          .set(
        roomDetails.toJson(),
      );

     await db.collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
            newChat.toJson(),
          );
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);

    return db
        .collection("chats")
        .doc(roomId) // Assuming roomId corresponds to a specific chat document
        .collection("messages") // Accessing the sub-collection of messages
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList());
  }
}
//pVf7g0Otq6Pl9siBC49GhOq0e4139LbsFAV6pmc13zSjTuUC3gatq9u2