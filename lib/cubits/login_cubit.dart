import 'package:ar_furniture_admin_panel/cubits/login_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(InitialLoginState());

  login(email,pass,context) async{
    emit(LoadingLoginState());
    try{
   await FirebaseFirestore.instance.collection('admin').where("email",isEqualTo: email).get().then((value)async {
      print("test");
     print(value.docs);
     if(value.docs.length!=0){
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((value){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logging In successfully!")));

         emit(LoginSuccessState());

       });
     }
    else{
     emit(LoginErrorState());
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect email or password")));
     }
    });

    }on FirebaseAuthException catch (e) {
      emit(LoginErrorState());
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No user found for that email!")));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong password provided for that user!")));
        print('Wrong password provided for that user.');
      }
    }
  }
}