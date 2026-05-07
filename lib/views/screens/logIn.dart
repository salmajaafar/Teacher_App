import 'package:flutter/material.dart';
import 'package:parent_app/core/colorsApp.dart';
import 'package:parent_app/views/screens/logBody.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      //backgroundColor:ColorsApp.backgroundcolor1, 
      body: SafeArea(
        child: LoginBody(),
      ),
    );
  }
}