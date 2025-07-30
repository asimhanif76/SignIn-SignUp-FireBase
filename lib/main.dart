import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signin_signup/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAwRV8Yjel5pwv2D3sM3Embeu9K0ZnMxrk",
        authDomain: "signin-signup-cde1d.firebaseapp.com",
        projectId: "signin-signup-cde1d",
        storageBucket: "signin-signup-cde1d.firebasestorage.app",
        messagingSenderId: "1040268358717",
        appId: "1:1040268358717:web:4563da4eadafef91306654",
        measurementId: "G-1JQBBLQYJY"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
