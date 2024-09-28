import 'dart:io';
import 'package:chatting_app/controller/profile_controller.dart';
import 'package:chatting_app/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/images.dart';
import '../../controller/image_picker_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RxBool isEdit = false.obs;
  ProfileController profileController = Get.put(ProfileController());
  ImagePickerController imagePickerController = Get.put(ImagePickerController());
  RxString imagePath = ''.obs; // Reactive string for image path
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    // Load saved image path from GetStorage
    imagePath.value = box.read('profileImage') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name =
    TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController addressController =
    TextEditingController(text: profileController.currentUser.value.address);
    TextEditingController genderController =
    TextEditingController(text: profileController.currentUser.value.gender);
    TextEditingController bioController =
    TextEditingController(text: profileController.currentUser.value.bio);
    TextEditingController maritalStatusController =
    TextEditingController(text: profileController.currentUser.value.maritalStatus);
    TextEditingController ageController =
    TextEditingController(text: profileController.currentUser.value.age);
    final TextEditingController progressController =
    TextEditingController(text: "88%");

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.to(LoginScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
                  () => Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (isEdit.value && imagePath.value.isNotEmpty)
                        ? FileImage(File(imagePath.value)) as ImageProvider<Object>
                        : (profileController.currentUser.value.profileImage != null
                        ? FileImage(File(profileController.currentUser.value.profileImage!)) as ImageProvider<Object>
                        : NetworkImage(AssetsImages.dummy_profile) as ImageProvider<Object>),
                    fit: BoxFit.cover,
                  ),

                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: isEdit.value
                      ? InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      String? pickedPath = await imagePickerController.pickImage(ImageSource.gallery);
                      if (pickedPath != null) {
                        imagePath.value = pickedPath; // Update the image path
                      }
                    },
                    child: Text(
                      "Choose Image",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                      : Container(),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 6.0, left: 16, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() => TextField(
                          controller: name,
                          enabled: isEdit.value,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: isEdit.value,
                            fillColor: Colors.grey[200],
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        )),
                      ),
                      SizedBox(width: 38.0),
                      Text(
                        ageController.text,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(width: 108.0),
                      Row(
                        children: [
                          CircularProgressIndicator(
                            value: 0.89,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            progressController.text,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Obx(() => TextField(
                    controller: addressController,
                    enabled: isEdit.value,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place_sharp, color: Colors.blueAccent),
                      filled: isEdit.value,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  )),
                  SizedBox(height: 4),
                  Obx(() => TextField(
                    controller: bioController,
                    enabled: isEdit.value,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.data_exploration, color: Colors.blueAccent),
                      filled: isEdit.value,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  )),
                  SizedBox(height: 4),
                  Obx(() => TextField(
                    controller: genderController,
                    enabled: isEdit.value,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.transgender, color: Colors.blueAccent),
                      filled: isEdit.value,
                      fillColor: Colors.grey[200],
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  )),
                  SizedBox(height: 4.0),
                  Obx(() => TextField(
                    controller: maritalStatusController,
                    enabled: isEdit.value,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.accessibility_new_outlined, color: Colors.blueAccent),
                      filled: isEdit.value,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  )),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
            () => isEdit.value
            ? FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () async {
            // Update the profile and set the image path in the profile
            await profileController.updateProfile(
              imagePath.value,
              name.text,
              ageController.text,
              addressController.text,
              bioController.text,
              genderController.text,
              maritalStatusController.text,
            );

            // Update the profile controller's currentUser image
            profileController.currentUser.value.profileImage = imagePath.value;

            // Save the image path to GetStorage
            box.write('profileImage', imagePath.value);

            FocusScope.of(context).unfocus();
            setState(() {
              isEdit.value = false; // Toggle edit mode
            });
          },
        )
            : FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              isEdit.value = true; // Toggle edit mode
            });
          },
        ),
      ),
    );
  }
}
