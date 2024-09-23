import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class ContactController extends GetxController {
  final storage = GetStorage();
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  RxList<UserModel> userList = <UserModel>[].obs;
@override
  void onInit()async{
    super.onInit();
  await getUsersList();

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

}
