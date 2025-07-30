import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    IconData icon = Icons.info,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    SnackPosition position = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
    
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      snackPosition: position,
      icon: Icon(icon, color: iconColor),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      borderRadius: 12,
      duration: duration,
    );
  }
}
