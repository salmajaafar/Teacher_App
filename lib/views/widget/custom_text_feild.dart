import 'package:flutter/material.dart';
import 'package:parent_app/core/colorsApp.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? icon; 

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
     // ),
      child: TextField(
        cursorColor: ColorsApp.PraimaryMain,
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
        decoration: InputDecoration(
         
          prefixIcon: icon != null 
              ? Icon(icon, color: ColorsApp.PraimaryMain, size: 22) 
              : null,
          
          labelText: hint, 
          labelStyle: const TextStyle(
            color: Color(0xffA8906E),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          
          filled: true,
          fillColor: Colors.white, 
          
         
border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorsApp.backgroundcolor2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorsApp.backgroundcolor2),
        ),
        focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: BorderSide(
    color: ColorsApp.PraimaryMain,
    width: 2, 
  ),
),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      )
    );
  }
}