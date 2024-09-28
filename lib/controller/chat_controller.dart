import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  RxString selectedImagePath = " ".obs;
  final storage = GetStorage();
  ProfileController controller = Get.put(ProfileController());
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxBool isUploadingImage = false.obs; // Track image upload status
  var uuid = Uuid();

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    return currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)
        ? currentUserId + targetUserId
        : targetUserId + currentUserId;
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    return currentUser.id! [0].codeUnitAt(0) > targetUser.id![0].codeUnitAt(0
    ) ? currentUser : targetUser;
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    return currentUser.id! [0].codeUnitAt(0) > targetUser.id![0].codeUnitAt(0
    ) ? targetUser : currentUser;
  }

  Future<void> sendMessage(String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    String nowTime = DateFormat('hh:mm a').format(DateTime.now());

    UserModel sender = getSender(controller.currentUser.value, targetUser);
    UserModel receiver = getReceiver(controller.currentUser.value, targetUser);
    String imageUrl = "";

    // Only attempt to upload if an image path is provided
    if (selectedImagePath.value.isNotEmpty && selectedImagePath.value.trim() != "") {
      isUploadingImage.value = true; // Set uploading state
      try {
        imageUrl = await controller.uploadFileToFirebase(selectedImagePath.value);
      } catch (e) {
        print("Error uploading image: $e");
        isUploadingImage.value = false; // Reset on error
        isLoading.value = false;
        return;
      }
      isUploadingImage.value = false; // Reset after upload
    }

    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.isEmpty ? null : imageUrl, // Ensure imageUrl is null if not provided
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: controller.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: nowTime,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );

    try {
      await db.collection("chats").doc(roomId).collection("messages").doc(chatId).set(newChat.toJson());
      await db.collection("chats").doc(roomId).set(roomDetails.toJson());
      selectedImagePath.value = " "; // Reset the image path after sending
    } catch (e) {
      print("Error sending message: $e");
    } finally {
      isLoading.value = false; // Ensure loading state is reset
    }
  }


  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);

    return db.collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
  }
}