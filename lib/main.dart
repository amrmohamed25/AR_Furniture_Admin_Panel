
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/models/shared_model.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:ar_furniture_admin_panel/screens/landingPage.dart';
import 'package:ar_furniture_admin_panel/screens/order_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ar_furniture_admin_panel/screens/view_furniture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/admin_cubit.dart';
import 'cubits/admin_states.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyA0IxEAsjwA94Im4FLw_SU3U7ctvNIQ-qY", appId: "1:290504032259:web:13f87a0645776fab7e8e36", messagingSenderId: "290504032259", projectId: "ar-furniture-7fb69"
    ,storageBucket: "gs://ar-furniture-7fb69.appspot.com")
  );
  var map={
    "category":"test_amr",
    "colors":["red"],
    "discount":"30",
    "img":"",
    "salesId":""
  };
  // await FirebaseFirestore.instance.collection("offer").add(map);
  // final doc =  FirebaseFirestore.instance.collection("category").doc("test_amr").collection("furniture").doc();
  // FurnitureModel furnitureModel=FurnitureModel(furnitureId: doc.id, name: "amr2", model: "", category: "test_amr", shared: [SharedModel(color: "red", colorName: "#ff00ff", image: "https://firebasestorage.googleapis.com/v0/b/ar-furniture-7fb69.appspot.com/o/furniture%2Ftest_amr%2Ftemp.jpg?alt=media&token=d3a937c1-a5db-479e-8622-4e71dc9047ef", price: "600", quantity: "30", discount: "")], ratings:{});
  // await FirebaseFirestore.instance.collection("category").doc("test_amr").collection("furniture").doc(doc.id).set(furnitureModel.toMap());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AdminCubit()..getAllData(),
      child: BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){},
        builder:(context,state){return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              // titleTextStyle: )
            ),
            primarySwatch: Colors.blue,
          ),
          home: LandingPage(),
        );}
      ),

    );
  }
}



