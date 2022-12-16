import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/login_states.dart';
import '../responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // var font=;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener:(context,state){},
        builder:(context,state){return Responsive(
            mobile:  Scaffold(
              extendBodyBehindAppBar: true,

              appBar: AppBar(
                title: MaterialButton(
                  // child:Text(""),
                  // splashColor: null,

                  hoverColor: Colors.transparent,
                  onPressed:(){

                },child: const Text("Lem 3afshk",style: TextStyle(fontFamily: "Montserrat",fontSize: 20,color: Colors.black),),)
                ,backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

                ),
                child: Center(
                  child: Container(

                    decoration: BoxDecoration(
                      // image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width/1.8,
                    height: MediaQuery.of(context).size.height/2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Login Screen",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                              const SizedBox(
                                height: 60,
                              ),
                              TextFormField(
                                controller: emailController,
                                cursorColor: Colors.grey,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                controller: passwordController,
                                obscureText: isPassword,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                    hintText: "Password",

                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          isPassword=!isPassword;
                                        });
                                      },
                                      icon: Icon(isPassword?Icons.visibility:Icons.visibility_off),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(50,50),
                                      backgroundColor: primaryColor
                                  )
                                  ,onPressed: (){
                                BlocProvider.of<LoginCubit>(context).login(emailController.text, passwordController.text, context);
                              }, child: const Text("Login")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            desktop: Scaffold(
          extendBodyBehindAppBar: true,

          appBar: AppBar(
            title: TextButton(onPressed:(){

            },child: const Text("Lem 3afshk",style: TextStyle(fontFamily: "Montserrat",fontSize: 20,color: Colors.black),),)
            ,backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

            ),
            child: Center(
              child: Container(

                decoration: BoxDecoration(
                  // image: const DecorationImage(image: AssetImage("assets/images/login_img.jpg"),fit: BoxFit.fill),

                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 500,
                height: MediaQuery.of(context).size.height/2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Login Screen",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.grey,
                        decoration: const InputDecoration(
                            hintText: "Email",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPassword,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            hintText: "Password",

                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  isPassword=!isPassword;
                                });
                              },
                              icon: Icon(isPassword?Icons.visibility:Icons.visibility_off),
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(50,50),
                            backgroundColor: primaryColor
                          )
                          ,onPressed: (){
                        BlocProvider.of<LoginCubit>(context).login(emailController.text, passwordController.text, context);
                      }, child: const Text("Login")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )); }
      ),
    );
  }
}