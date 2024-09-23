import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/images.dart';
import '../../models/user_model.dart';
import 'login_user_info.dart';

class UsersProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const UsersProfileScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginUserInfo(
              profileImage: userModel.profileImage ?? AssetsImages.defaultProfileUrl,
              userName: userModel.name ?? "Users",
              userAge: userModel.age ?? "23",
              userAddress: userModel.address ?? "Not Provided",
            )
          ],
        ),
      ),
    );
  }
}
