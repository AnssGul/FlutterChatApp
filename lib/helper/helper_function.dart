import 'package:shared_preferences/shared_preferences.dart';
class HelperFunction {



  //keys
  static String userLoggedInkey="LOGGEDINKEy";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEy";
  //saving the data to SF
  static Future<bool> SaveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInkey, isUserLoggedIn);
  }
  static Future<bool> SaveUserEmailSF(
      String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }
  static Future<bool> SaveUserNameSf(
      String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey ,userName);
  }
//getting data to SF

  static Future<bool?> getUserLoggedInStatus() async{
    SharedPreferences sf =await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInkey);
  }
  static Future<String?> getUserEmailFromSF() async{
    SharedPreferences sf =await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
  static Future<String?> getUserNameFromSF() async{
    SharedPreferences sf =await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}