import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'package:signin_signup/views/sign_up_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? uid = sp.getString('uid');

    // Delay for splash effect (optional)
    await Future.delayed(Duration(seconds: 2));

    if (uid != null && uid.isNotEmpty) {
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => SignUpPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Run checkLogin() after build
    WidgetsBinding.instance.addPostFrameCallback((_) => checkLogin());

    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
