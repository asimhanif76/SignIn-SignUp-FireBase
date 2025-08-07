import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signin_signup/Commons/app_images.dart';
import 'package:signin_signup/Commons/app_strings.dart';
import 'package:signin_signup/Controllers/auth_controllers.dart';
import 'package:signin_signup/Utils/email_password_validators.dart';
import 'package:signin_signup/Widgets/getprofile_image.dart';
import 'package:signin_signup/Widgets/my_button.dart';
import 'package:signin_signup/Widgets/my_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  AuthControllers authControllers = Get.put(AuthControllers());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: authControllers.formKey,
        child: Padding(
          padding: EdgeInsets.all(height * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Obx(
                  () => Text(
                    authControllers.isLoginPage.value
                        ? AppStrings.welcome_back
                        : AppStrings.welcome_to_app,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    authControllers.isLoginPage.value
                        ? AppStrings.hello_there_sign_in_to_continue
                        : AppStrings.hello_there_sign_up_to_continue,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: authControllers.isLoginPage.value
                        ? height * 0.1
                        : height * 0.05,
                  ),
                ),
                Obx(
                  () => authControllers.isLoginPage.value
                      ? SizedBox()
                      : Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade200,
                                backgroundImage: authControllers
                                        .imagePath.value.isNotEmpty
                                    ? getProfileImage(
                                        authControllers.imagePath.value)
                                    : AssetImage(AppImages.facebook),
                                radius: 50,
                              ),
                              Positioned(
                                  bottom: -10,
                                  right: -10,
                                  child: InkWell(
                                      onTap: () {},
                                      child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Color(0xFFFDFDFD),
                                              context: context,
                                              builder: (context) {
                                                return _bottomDialog(
                                                    context, height, width);
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit_square,
                                            color: Colors.green,
                                          ))))
                            ],
                          ),
                        ),
                ),
                Obx(
                  () => SizedBox(
                    height:
                        authControllers.isLoginPage.value ? 0 : height * 0.02,
                  ),
                ),
                Obx(
                  () => authControllers.isLoginPage.value
                      ? SizedBox()
                      : Column(
                          children: [
                            MyTextFormField(
                                controller: authControllers.nameController,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Enter Name';
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: 'Full Name',
                                icon: Icon(Icons.person)),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            MyTextFormField(
                                controller: authControllers.userNameController,
                                validator:
                                    EmailPasswordValidators.validateUsername,
                                hintText: 'User Name',
                                icon: Icon(Icons.person)),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextFormField(
                              controller: authControllers.dobController,
                              validator: (value) {
                                if (value == '') {
                                  return 'Enter Date Of Birth';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: 'Date Of Birth',
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1970),
                                          lastDate: DateTime.now(),
                                        );

                                        if (pickedDate != null) {
                                          authControllers.dob = pickedDate;
                                          String formattedDate =
                                              "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                                          authControllers.dobController.text =
                                              formattedDate;
                                        }
                                      },
                                      icon: Icon(Icons.calendar_month))),
                              readOnly: true,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        ),
                ),
                MyTextFormField(
                  controller: authControllers.emailController,
                  validator: EmailPasswordValidators.validateEmail,
                  hintText: AppStrings.enter_email,
                  icon: Icon(Icons.mail),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                MyTextFormField(
                  controller: authControllers.passwordController,
                  validator: EmailPasswordValidators.validatePassword,
                  hintText: AppStrings.enter_password,
                  icon: Icon(Icons.lock),
                  isPasswordField: true,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Obx(
                  () => authControllers.isLoginPage.value
                      ? SizedBox()
                      : MyTextFormField(
                          controller: authControllers.confirmPasswordController,
                          validator: EmailPasswordValidators.validatePassword,
                          hintText: 'Confirm Password',
                          icon: Icon(Icons.lock),
                          isPasswordField: true,
                        ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Obx(
                  () => authControllers.isLoding.value
                      ? Container(
                          height: width * 0.14,
                          alignment: Alignment.center,
                          child: Transform.scale(
                            scale: 0.7,
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                        )
                      : MyButton(
                          onTap: () {
                            authControllers.isLoginPage.value
                                ? authControllers.signIn(context)
                                : authControllers.signUp(context);
                          },
                          buttonName: authControllers.isLoginPage.value
                              ? AppStrings.signin
                              : AppStrings.signup),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      AppStrings.forgot_password,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: authControllers.isLoginPage.value
                        ? height * 0.1
                        : height * 0.01,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      AppStrings.or,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: authControllers.isLoginPage.value
                        ? height * 0.05
                        : height * 0.01,
                  ),
                ),
                MyButton(
                  buttonName: AppStrings.sign_in_with_google,
                  color: Colors.green,
                  onTap: () {},
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                MyButton(
                  buttonName: AppStrings.sign_in_with_facebook,
                  color: Colors.green,
                  onTap: () {},
                ),
                SizedBox(
                  height: height * 0.039,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        authControllers.isLoginPage.value
                            ? AppStrings.dont_have_an_account
                            : AppStrings.you_already_have_an_account,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    InkWell(
                      onTap: () {
                        authControllers.changeSignUpSignIn();
                      },
                      child: Obx(
                        () => Text(
                          authControllers.isLoginPage.value
                              ? AppStrings.signup
                              : AppStrings.signin,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomDialog(BuildContext context, double height, double width) {
    return SizedBox(
      height: height * 0.15,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Row(
          children: [
            _imagePickerContainer(
              text: "Camera",
              icon: Icons.add_a_photo_outlined,
              onTap: () {
                authControllers.pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: width * 0.04,
            ),
            _imagePickerContainer(
              text: "Gallery",
              icon: Icons.add_photo_alternate_outlined,
              onTap: () {
                authControllers.pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePickerContainer(
      {required String text,
      required IconData icon,
      required VoidCallback onTap}) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(),
          color: Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(text),
            Icon(icon),
          ],
        ),
      ),
    ));
  }
}
