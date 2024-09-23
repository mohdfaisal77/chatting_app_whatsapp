// import 'package:chatting_app/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// class ProfileController extends GetxController {
//   final auth = FirebaseAuth.instance;
//   final storage = GetStorage();
//   RxBool isLoading =false.obs;
//
//   // Initialize currentUser with empty values
//   Rx<UserModel> currentUser = UserModel().obs;
//
//   @override
//   void onInit() async{
//     super.onInit();
//     // Load user details when the controller is initialized
//     await getUserDetails();
//   }
//
//   Future<void> getUserDetails() async {
//     try {
//       // Get the current user ID
//       // String? userId = auth.currentUser?.uid;
//        String? userId = auth.currentUser?.uid;
//       if (userId == null) {
//         print('User is not logged in');
//         return; // Exit if the user is not logged in
//       }
//
//       // Read user data from GetStorage
//       Map<String, dynamic>? userData = storage.read('user_$userId');
//
//       // Check if user data exists
//       if (userData != null) {
//         // Create a UserModel from the JSON data and update currentUser
//         currentUser.value = UserModel.fromJson(userData);
//         print('User details loaded: ${currentUser.value.name}');
//       } else {
//         print('No user data found for ID: $userId');
//       }
//     } catch (e) {
//       print('Error loading user details: $e');
//     }
//   }
//
//   Future<void> updateProfile(String? imgUrl,String? name,String? age,String? address, String? bio,
//       String? gender, String? maritalStatus)async{
//     String? userId = auth.currentUser?.uid;
//     var updatedUser = UserModel(
//       id: auth.currentUser!.uid,
//       // Get the current user ID
//       name: name,
//       age: age,
//       bio: bio,
//       address: address,
//       gender: gender,
//       maritalStatus: maritalStatus,
//       profileImage: , // You can set a default value or pass it as a parameter
//     );
//     isLoading.value=true;
//
//     await storage.write('user_$userId', (updatedUser.toJson()));
//     isLoading.value=false;
//
//
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final storage = GetStorage();
  RxBool isLoading = false.obs;

  // Initialize currentUser with empty values
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    // Load user details when the controller is initialized
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      String? userId = auth.currentUser?.uid;
      if (userId == null) {
        print('User is not logged in');
        return; // Exit if the user is not logged in
      }

      // Read user data from GetStorage
      Map<String, dynamic>? userData = storage.read('user_$userId');

      // Check if user data exists
      if (userData != null) {
        currentUser.value = UserModel.fromJson(userData);
        print('User details loaded: ${currentUser.value.name}');
      } else {
        print('No user data found for ID: $userId');
      }
    } catch (e) {
      print('Error loading user details: $e');
    }
  }

  Future<void> updateProfile(String? profileImage, String? name, String? age,
      String? address, String? bio, String? gender, String? maritalStatus) async {
    String? userId = auth.currentUser?.uid;

    if (userId == null) {
      print('User is not logged in');
      return; // Exit if the user is not logged in
    }

    isLoading.value = true;

    // Create updated user model
    var updatedUser = UserModel(
      profileImage: profileImage,
      id: userId,
      name: name,
      age: age,
      bio: bio,
      address: address,
      gender: gender,
      maritalStatus: maritalStatus,
       // Set the new image URL
    );

    // Save updated user data in GetStorage
    await storage.write('user_$userId', updatedUser.toJson());

    // Update currentUser with the new data
    currentUser.value = updatedUser;

    //await getUserDetails();

    isLoading.value = false;

    print('User profile updated: ${currentUser.value.name}');
  }
}
