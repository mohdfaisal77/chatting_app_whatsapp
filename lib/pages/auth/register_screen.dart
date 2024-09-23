import 'package:chatting_app/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email= TextEditingController();
    TextEditingController password= TextEditingController();
    TextEditingController name= TextEditingController();
    TextEditingController age= TextEditingController();
    TextEditingController gender= TextEditingController();
    TextEditingController address= TextEditingController();
    TextEditingController bio= TextEditingController();
    TextEditingController maritialStatus= TextEditingController();
    AuthController authController =Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Screen",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(  // Add SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(26.0),  // General padding for the whole screen
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: Icon(Icons.person), // Changed to an appropriate icon
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: age,
                        decoration: InputDecoration(
                          hintText: "Age",
                          prefixIcon: Icon(Icons.calendar_today), // Changed to an appropriate icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: gender,
                        decoration: InputDecoration(
                          hintText: "Gender",
                          prefixIcon: Icon(Icons.transgender), // Changed to an appropriate icon
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: maritialStatus,
                        decoration: InputDecoration(
                          hintText: "Marital Status",
                          prefixIcon: Icon(Icons.wc), // Changed to an appropriate icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: bio,
                        decoration: InputDecoration(
                          hintText: "Bio",
                          prefixIcon: Icon(Icons.info), // Changed to an appropriate icon
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                          hintText: "Address",
                          prefixIcon: Icon(Icons.home), // Changed to an appropriate icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(() => authController.isLoading.value ? CircularProgressIndicator() :     Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(btnName: 'Register', icon: Icons.lock_open_sharp,onTap: (){
                    authController.createUser(email.text, password.text,name.text,age.text,address.text,bio.text,gender.text,maritialStatus.text);
                    print("Account Created");
                    // Get.offAllNamed("/home_screen");
                  },),
                ],

              )),
              Container(
                  margin: EdgeInsets.all(26),
                  child: Row(
                    children: [
                      Text("Already have an Account?"),
                      InkWell(
                          onTap: (){
                            Get.offAllNamed("/login_screen");
                          },
                          child: Text("Login"))
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
