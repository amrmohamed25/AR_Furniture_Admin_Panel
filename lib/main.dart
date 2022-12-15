import 'package:ar_furniture_admin_panel/screens/category_screen.dart';
import 'package:ar_furniture_admin_panel/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyA0IxEAsjwA94Im4FLw_SU3U7ctvNIQ-qY", appId: "1:290504032259:web:13f87a0645776fab7e8e36", messagingSenderId: "290504032259", projectId: "ar-furniture-7fb69")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const  CategoryScreen(),
    );
  }
}



