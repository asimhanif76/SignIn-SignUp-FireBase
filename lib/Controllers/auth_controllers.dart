import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup/Utils/custom_snackbar.dart';
import 'package:signin_signup/views/home_page.dart';
import 'package:signin_signup/models/user_model.dart';
import 'package:signin_signup/views/sign_up_page.dart';

class AuthControllers extends GetxController {
  RxBool isLoginPage = true.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController createDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isLoding = false.obs;
  DateTime? dob;

  void signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoding.value = true;
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        if (userCredential.user != null) {
          Get.offAll(HomePage());
          CustomSnackbar.show(
            title: "Signup Successful",
            message: "Welcome to the app!",
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
          emailController.clear();
          passwordController.clear();
        }
        String userId = userCredential.user!.uid;
        SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.setString('uid', userId);
        isLoding.value = false;
      } catch (e) {
        print("Exception:  $e");
        CustomSnackbar.show(
          title: "SignIn Failed",
          message: e.toString().split(']')[1].trim(),
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
        isLoding.value = false;
      }
    } else {}
  }

  RxString imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource imageSource) async {
    final XFile? image = await _picker.pickImage(source: imageSource);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  RxString url = ''.obs;

  uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref('Profile Pics')
        .child(emailController.text.toString())
        .putFile(File(imagePath.value));

    TaskSnapshot taskSnapshot = await uploadTask;

    url.value = await taskSnapshot.ref.getDownloadURL();
  }

  void signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoding.value = true;
      try {
        if (passwordController.text.trim() !=
            confirmPasswordController.text.trim()) {
          isLoding.value = false;
          CustomSnackbar.show(
            title: "Password Mismatch",
            message: "Password and Confirm Password do not match",
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
          return;
        }

        // **Upload image first**
        // if (imagePath.value.isNotEmpty) {
        //   await uploadData(); // This will set url.value
        // }

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        if (userCredential.user != null) {
          final user = UserModel(
              uid: userCredential.user!.uid,
              name: nameController.text.trim(),
              userName: userNameController.text.trim(),
              userImage: url.value,
              dob: Timestamp.fromDate(dob!),
              userEmail: emailController.text.trim());

          // Save to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(user.toJson());

          SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('uid', user.uid);

          Get.offAll(HomePage());

          CustomSnackbar.show(
            title: "Signup Successful",
            message: "Welcome to the app!",
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
        }

        nameController.clear();
        userNameController.clear();
        dobController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        isLoding.value = false;
      } catch (e) {
        print(e);
        CustomSnackbar.show(
            title: "SignUp Failed",
            message: e.toString().split('i')[1].trim(),
            backgroundColor: Colors.red);
        isLoding.value = false;
      }
    } else {
      isLoding.value = false;
    }
  }

  void changeSignUpSignIn() {
    nameController.clear();
    userNameController.clear();
    dobController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isLoginPage.toggle();
  }

  void isUserLogedin(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final uid = sp.getString('uid');
    if (uid != null && uid.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ));
    }
  }

  void logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('uid');
    await FirebaseAuth.instance.signOut();
    Get.offAll(SignUpPage());
  }
}
