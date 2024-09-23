import 'package:chatting_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final storage = GetStorage();
  RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //Get.offAllNamed("/home_screen");
      Get.offAllNamed("/bottom_navbar");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Provided password is too weak");
      } else if (e.code == 'wrong-password') {
        print("Provided password is wrong");
      } else if (e.code == 'email-already-in-use') {
        print("The account already exists for that email");
      } else {
        print(e.code);
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> createUser(
      String email,
      String password,
      String name,
      String age,
      String address,
      String bio,
      String gender,
      String maritalStatus) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("User created successfully");

      // Store user data in GetStorage
await initUser(name, age, address, bio, gender, maritalStatus);
     // storage.write('userEmail', email);


      // Optionally navigate to home or any other screen
      Get.offAllNamed("/home_screen");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Provided password is too weak");
      } else if (e.code == 'email-already-in-use') {
        print("The account already exists for that email");
      } else {
        print(e.code);
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> logOutUser() async {
    await auth.signOut();
    Get.offAllNamed("/login_screen");
  }

  Future<void> initUser(String name, String age, String address, String bio,
      String gender, String maritalStatus) async {
    // Create a new UserModel instance
    var newUser = UserModel(
      id: auth.currentUser!.uid,
      // Get the current user ID
      name: name,
      age: age,
      bio: bio,
      address: address,
      gender: gender,
      maritalStatus: maritalStatus,
      profileImage: '', // You can set a default value or pass it as a parameter
    );

    // Initialize GetStorage

    // Save user data in GetStorage using user ID as key
  try{
    storage.write('user_${newUser.id}', newUser.toJson());

    print('User data saved for ID: ${newUser.id}');
  }catch(e){
    print(e);
  }
  }
}
