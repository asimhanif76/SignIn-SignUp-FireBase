import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  RxBool isLodingData = false.obs;
  RxBool isUpdating = false.obs;
  RxBool isDeleting = false.obs;

  DateTime? dob;

  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController dobController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    dobController = TextEditingController();
    loadUserData();
  }

  Future<void> loadUserData() async {
    print('Loading user data...');
    isLodingData.value = true;
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final uid = sp.getString('uid');
      if (uid != null && uid.isNotEmpty) {
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          final data = userDoc.data()!;
          nameController.text = data['name'] ?? '';
          userNameController.text = data['userName'] ?? '';
          emailController.text = data['userEmail'] ?? '';
          dobController.text = data['dob'] is Timestamp
              ? (data['dob'] as Timestamp)
                  .toDate()
                  .toLocal()
                  .toString()
                  .split(' ')[0]
              : data['dob'].toString();
          print('User data loaded successfully.');
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      Get.snackbar("Error", "Failed to load user data.",
          backgroundColor: Colors.red);
    } finally {
      isLodingData.value = false;
    }
  }

  void updateProfile() async {
    isUpdating.value = true;
    print('Updating profile...');
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final uid = sp.getString('uid');

      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userData = userDoc.data()!;
      if (nameController.text != userData['name'] ||
          userNameController.text != userData['userName'] ||
          dobController.text !=
              (userData['dob']).toDate().toLocal().toString().split(' ')[0]) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'name': nameController.text,
          'userName': userNameController.text,
          'userEmail': emailController.text,
          'New int Add': 01234,
          'New String Add': 'New String Value',
          'dob': Timestamp.fromDate(dob ?? DateTime.now()),
        });
        isUpdating.value = false;
        print('Profile updated successfully.');
        Get.snackbar(
            "Profile Updated", "Your profile has been updated successfully.",
            backgroundColor: Colors.green);
      } else {
        Get.snackbar("Error", "Changes are not detected.",
            backgroundColor: Colors.red);
        isUpdating.value = false;
      }
    } catch (e) {
      isUpdating.value = false;
      print('Error updating profile: $e');
      Get.snackbar("Error", "Failed to update profile.",
          backgroundColor: Colors.red);
    }
  }

  Future deleteFields() async {
    print('Deleting fields...');
    isDeleting.value = true;
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final uid = sp.getString('uid');
      if (uid != null && uid.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'userName': FieldValue.delete(),
          'dob': FieldValue.delete(),
          'name': FieldValue.delete(),
          'New int Add': FieldValue.delete(),
          'New String Add': FieldValue.delete(),
        });
        isDeleting.value = false;
        print('Fields deleted successfully.');
        Get.snackbar("Deleted",
            "Name, UserName, Date Of Birth field deleted from Firebase.",
            backgroundColor: Colors.green);
      } else {
        Get.snackbar("Error", "User not found.", backgroundColor: Colors.red);
        isDeleting.value = false;
      }
    } catch (e) {
      isDeleting.value = false;
      print('Error deleting fields: $e');
      Get.snackbar("Error", "Failed to delete fields.",
          backgroundColor: Colors.red);
    }
  }
}
