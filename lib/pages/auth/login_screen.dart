import 'package:chatting_app/controller/auth_controller.dart';
import 'package:chatting_app/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController email= TextEditingController();
    TextEditingController password= TextEditingController();

    AuthController authController =Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Screen",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 20,),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),

                    SizedBox(height: 20),

                      TextFormField(
                        controller: password,

                        decoration: InputDecoration(
                          hintText: "Password",

                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),




              SizedBox(height: 20),
        Obx(() =>    authController.isLoading.value ? CircularProgressIndicator() :   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(btnName: 'Login', icon: Icons.lock_open_sharp, onTap: () {
              authController.login(email.text, password.text);
              // Get.offAllNamed("/home_screen");
            },),

          ],

        )),
              Container(
                margin: EdgeInsets.all(56),

                  child: Row(
                    children: [
                      Text("Don't have an Account?"),
                      InkWell(
                          onTap: (){
                            Get.offAllNamed("/register_screen");
                          },
                          child: Text("Sign up",style: TextStyle(color: Colors.blueAccent),))
                    ],
                  )
              )
            ],
        )

    );
  }
}
