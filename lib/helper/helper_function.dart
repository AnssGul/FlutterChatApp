import 'package:shared_preferences/shared_preferences.dart';
class HelperFunction {
  //saving the data to SF
  //getting data to SF

  //keys
  static String userLoggedInkey="LOGGEDINKEy";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEy";


  static Future<bool?> getUserLoggedInStatus() async{
    SharedPreferences sf =await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInkey);
  }
}