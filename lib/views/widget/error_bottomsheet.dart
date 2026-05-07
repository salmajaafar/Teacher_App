import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_app/core/colorsApp.dart';


class ErrorBottomSheet {
  
  static void showErrorBottomSheet({required String title, required String message}) {
    Get.bottomSheet(
      Container(
        width: 400,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsApp.backgroundcolor1, 
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 50),
            SizedBox(height: 10),
            Text(
             title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.red),
            ),
            SizedBox(height: 10),
            Text(
             message, 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(); 
              },
              child: Text("Close"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: ColorsApp.backgroundcolor1,
              ),
            ),
          ],
        ),
      ),
      isDismissible: true, 
    );
  }
}
