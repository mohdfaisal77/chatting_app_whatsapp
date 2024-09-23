import 'package:chatting_app/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/image_picker_controller.dart';
import '../../controller/profile_controller.dart';

class LoginUserInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userAge;
  final String userAddress;

  const LoginUserInfo({
    super.key,
    required this.profileImage,
    required this.userName,
    required this.userAge,
    required this.userAddress,
  });

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ImagePickerController imagePickerController = Get.put(ImagePickerController());

    // Remove the Scaffold here
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: AssetImage(AssetsImages.defaultProfileUrl),
               image: NetworkImage(profileImage),
              fit: BoxFit.cover,
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
                    child: Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(width: 38.0),
                  Text(
                    userAge,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                userAddress,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ],
    );
  }
}
