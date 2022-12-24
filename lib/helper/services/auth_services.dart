import 'package:chatapp_firebase/helper/helper_function.dart';
import 'package:chatapp_firebase/helper/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login

  Future loginwithUserNameAndPasword(String email,String password)async{
    try{
      User user =(await firebaseAuth .signInWithEmailAndPassword(
          email: email, password: password)).user!;
      if(user!=null){
        //call our database service to update the user database

        return true;
      }
    } on FirebaseAuthException catch (e){

      return e.message;
    }
  }

//register
Future registerUserWithEmailandPassword(String fullName,String email,String password)async{
  try{
    User user =(await firebaseAuth .createUserWithEmailAndPassword(
        email: email, password: password)).user!;
    if(user!=null){
      //call our database service to update the user database
     await DatabaseService(uid: user.uid).SavingtheData(fullName, email);
      return true;
    }
  } on FirebaseAuthException catch (e){

    return e.message;
  }
}
// signout
Future signOut() async {
  try{
await HelperFunction.SaveUserLoggedInStatus(false);
await HelperFunction.SaveUserEmailSF("");
await HelperFunction.SaveUserNameSf("");
await firebaseAuth.signOut();
  }catch(e){
    return null;
  }
}
}