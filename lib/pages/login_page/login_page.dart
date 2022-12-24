import 'package:chatapp_firebase/helper/register_page.dart';
import 'package:chatapp_firebase/helper/services/auth_services.dart';
import 'package:chatapp_firebase/pages/login_page/widget/fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../../helper/services/database_service.dart';
import '../home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _loading=false;
  AuthServices authServices =AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body:_loading? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),): SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Wave",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Login now to see what they are talking!",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Image.asset("images/loginn.png"),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      )),
                  onChanged: (val) {
                    email = val;
                    print(email);
                  },
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                //check the validation

                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      )),
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Password should be at least 6 characters";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    password = val;
                    print(password);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Login();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: "don't have an account?",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Register here",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                nextScreen(context, RegisterPage());
                              })
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Login() async {
    if(formkey.currentState!.validate()){
      setState(() {

        _loading =true;
      });
      await authServices.loginwithUserNameAndPasword(email, password).
      then((value) async{
        if(value==true){
          QuerySnapshot snapshot= await DatabaseService(
              uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          //saving the data to the sharedpreference
          await HelperFunction.SaveUserLoggedInStatus(true);
          await HelperFunction.SaveUserEmailSF(email);
          await HelperFunction.SaveUserNameSf(
            snapshot.docs[0]["fullname"]
          );

          nextScreenReplace(context, const HomePage());

        }

        else{
          showSnackBar(context,Colors.red,value);
          //showSnakBar(context,Colors.red,value);
          setState(() {
            _loading=false;
          });
        }
        //saving shared preferencer state


      });
    }
  }
}
