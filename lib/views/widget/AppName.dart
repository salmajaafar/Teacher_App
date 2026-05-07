import 'package:flutter/material.dart';
import 'package:parent_app/core/colorsApp.dart';

class nameApp extends StatelessWidget {
  const nameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Text(
                "Meded",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.PraimaryMain,
                ),
              );
  }
}