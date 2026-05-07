import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/screens/logIn.dart';
import 'package:parent_app/views/screens/sign_up_screen.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/logo.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.Color1,
      body: Center(
        child: Container(
          width: 0.9.sw,
          height: 0.88.sh,
          decoration: BoxDecoration(
            color: ColorsApp.Color1,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              /// Top Shape
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: ColorsApp.PraimaryMain,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(120),
                    ),
                  ),
                ),
              ),

              /// Logo
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Column(
                  children: const [
                    CircleAvatar(
                        radius: 45,
                        backgroundColor: ColorsApp.backgroundcolor2,
                        child: Logo()),
                  ],
                ),
              ),

              /// Content
              Positioned.fill(
                top: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      /// Title
                      const Text(
                        "PARTNERS IN THEIR\nSUCCESS JOURNEY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'KiwiMaru', 
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: ColorsApp.PraimaryMain,
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// Subtitle
                      const Text(
                        "Follow your child's educational progress moment\n by moment, and stay\n in constant contact with the school in a safe and\n advanced environment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Spacer(),

                     
                      CustomButton(
                        textButton: "Sign Up",
                        icon: Icons.person_add,
                        onPressed: () {
                           Get.to(() => SignupView());
                        },
                        width: 250,
                      ),
                      const SizedBox(height: 15),

                      CustomButton(
                        textButton: "log in",
                        icon: Icons.login,
                        backgroundColor: ColorsApp.backgroundcolor1,
                        borderColor: ColorsApp.PraimaryMain,
                        textColor: ColorsApp.PraimaryMain,
                        onPressed: () {
                          Get.to(() =>  LoginScreen());
                        },
                        width: 250,
                      ),

                      const SizedBox(height:60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
