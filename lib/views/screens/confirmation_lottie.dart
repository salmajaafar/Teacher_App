import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfirmationLottie extends StatelessWidget {
  const ConfirmationLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/Book loading.json', repeat: false),
      ),
    );
  }
}
