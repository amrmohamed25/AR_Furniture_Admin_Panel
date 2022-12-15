import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SimpleLogin(),
    );
  }
}
class SimpleLogin extends StatefulWidget {
  // const SimpleLogin({Key? key}) : super(key: key);

  @override
  State<SimpleLogin> createState() => _SimpleLoginState();
}

class _SimpleLoginState extends State<SimpleLogin> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                hintText: "Hello"
            ),
            controller: emailController,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Hello"
            ),
            controller: passwordController,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: ()async{
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
              print("Done");
            }).catchError((onError){print("Sad");});

            }, child: Text("Login"))
        ],
      ),
    );
  }
}


