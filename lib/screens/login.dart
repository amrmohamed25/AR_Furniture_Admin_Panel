import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,

          ),
          TextFormField(
            controller: passwordController,
            obscureText: isPassword,
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: (){
                  setState(() {
                    isPassword=!isPassword;
                  });
                },
                icon: Icon(isPassword?Icons.visibility:Icons.visibility_off),
              )
            ),
          ),
        ],
      ),
    );
  }
}
