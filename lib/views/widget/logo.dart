import 'package:flutter/material.dart';
import 'package:parent_app/core/colorsApp.dart';

class Logo extends StatelessWidget {
    const Logo({super.key});
  
    @override
    Widget build(BuildContext context) {
      return  Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorsApp.backgroundcolor2,
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ) ;
    }
  }