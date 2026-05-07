// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:parent_app/controllers/sign_up_controller.dart';
// import 'package:parent_app/core/colorsApp.dart';
// import 'package:parent_app/views/screens/logIn.dart';
// import 'package:parent_app/views/widget/buttonStyle.dart';
// import 'package:parent_app/views/widget/custom_text_feild.dart';

// class SignupView extends StatelessWidget {
//   final SignUpController controller = Get.put(SignUpController());

//   SignupView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsApp.backgroundcolor2,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),

//                 Center(
//                   child: Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: ColorsApp.PraimaryMain,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 /// FULL NAME
//                 CustomTextField(
//                   hint: "FULL NAME",
//                   controller: controller.fullNameController,
//                 ),

//                 const SizedBox(height: 15),

//                 /// EMAIL
//                 CustomTextField(
//                   hint: "EMAIL ADDRESS",
//                   controller: controller.emailController,
//                 ),

//                 const SizedBox(height: 15),

//                 /// STUDENT NUMBER
//                 CustomTextField(
//                   hint: "STUDENT NUMBER",
//                   controller: controller.studentNumberController,
//                 ),

//                 const SizedBox(height: 15),

//                 /// PASSWORD
//                 CustomTextField(
//                   hint: "PASSWORD",
//                   controller: controller.passwordController,
//                   isPassword: true,
//                 ),

//                 const SizedBox(height: 15),

//                 /// CONFIRM PASSWORD
//                 CustomTextField(
//                   hint: "CONFIRM",
//                   controller: controller.confirmPasswordController,
//                   isPassword: true,
//                 ),

//                 const SizedBox(height: 25),

//                 /// BUTTON
//                 Obx(() => controller.isLoading.value
//                     ? const Center(child: CircularProgressIndicator())
//                     : CustomButton(
//                         textButton: "Create Account",
//                         onPressed: controller.createAccount,
//                         width: double.infinity,
//                         backgroundColor: ColorsApp.PraimaryMain,
//                         textColor: ColorsApp.backgroundcolor1,
//                       )),

//                 const SizedBox(height: 20),

//                 /// SIGN IN
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(() => LoginScreen());
//                     },
//                     child: Text.rich(
//                       TextSpan(
//                         text: "Already have an account? ",
//                         style: TextStyle(color: ColorsApp.PraimaryMain),
//                         children: const [
//                           TextSpan(
//                             text: "Sign In",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               decoration: TextDecoration.underline,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_app/controllers/sign_up_controller.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/screens/logIn.dart';
import 'package:parent_app/views/widget/buttonStyle.dart';
import 'package:parent_app/views/widget/custom_text_feild.dart';

class SignupView extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsApp.backgroundcolor2,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorsApp.PraimaryMain,
                    ColorsApp.PraimaryMain.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.PraimaryMain.withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Create\nAccount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color:Color(0xffCBB89C), 
                      // Colors.white,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Join our community",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 260),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "FULL NAME",
                          controller: controller.fullNameController,
                          icon: Icons.person_outline_rounded,
                        ),
                       
                     
                        const SizedBox(height: 15),

                        CustomTextField(
                          hint: "EMAIL ADDRESS",
                          controller: controller.emailController,
                          icon: Icons.alternate_email_rounded,
                        ),

                        const SizedBox(height: 15),

                        CustomTextField(
                          hint: "STUDENT NUMBER",
                          controller: controller.studentNumberController,
                          icon: Icons.badge_outlined,
                        ),

                        const SizedBox(height: 15),

                        CustomTextField(
                          hint: "PASSWORD",
                          controller: controller.passwordController,
                          icon: Icons.lock_open_rounded,
                          isPassword:
                              true, 
                        ),

                        const SizedBox(height: 15),

                        CustomTextField(
                          hint: "CONFIRM PASSWORD",
                          controller: controller.confirmPasswordController,
                          icon: Icons.lock_rounded,
                          isPassword: true,
                        ),

                        const SizedBox(height: 40),


                        Obx(() => controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                height: 58,
                                 child:CustomButton(onPressed: controller.createAccount,
                                 textButton:"Create Account", 
                                 )
                               
                                ),
                              ),

                        const SizedBox(height: 25),

               
                        TextButton(
                          onPressed: () => Get.to(() => LoginScreen()),
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.grey[600]),
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: TextStyle(
                                    color: ColorsApp.PraimaryMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
