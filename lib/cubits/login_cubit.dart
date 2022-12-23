import 'package:ar_furniture_admin_panel/cubits/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(InitialLoginState());

  login(email,pass,context) async{
    emit(LoadingLoginState());
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((value){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logging In successfully!")));

      emit(LoginSuccessState());

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