import 'package:chatting_app/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class ContactController extends GetxController {
  final storage = GetStorage();
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final db = FirebaseFirestore.instance;
  RxList<ChatRoomModel> chatRoomList= <ChatRoomModel>[].obs;

  RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUsersList();
    await getChatRoomList();
  }

  Future<void> getUsersList() async {
    userList.clear(); // Clear the existing list to avoid duplication

    // Get all keys from GetStorage
    final keys = storage.getKeys();

    for (var key in keys) {
      // Assuming keys are stored in the format "user_<userId>"
      if (key.startsWith('user_')) {
        final userData = storage.read(key);

        if (userData != null) {
          // Create UserModel from the user data
          UserModel user = UserModel.fromJson(userData);
          userList.add(user);
        }
      }
    }
  }
  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db.collection('chats').orderBy("timestamp",descending: true).get().then((value) {
      tempChatRoom =
          value.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList();
    });
    chatRoomList.value = tempChatRoom
        .where(
          (e) => e.id!.contains(auth.currentUser!.uid),
        )
        .toList();
    print(chatRoomList);
    print(tempChatRoom);
  }
}
