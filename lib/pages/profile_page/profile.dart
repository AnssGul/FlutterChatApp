import 'package:chatapp_firebase/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_firebase/helper/services/auth_services.dart';

import '../../helper/helper_function.dart';
import '../login_page/login_page.dart';
import '../login_page/widget/fields.dart';
class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key,required this.userName,required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthServices authServices =AuthServices();

  String userName="";
  String email="";
  //AuthServices authServices=AuthServices();
  //@override
  void initState() {
    gettingUserData();
    // TODO: implement initState
    super.initState();
  }
  gettingUserData() async{
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {

        email=value!;
      });
    }) ;
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {

        userName=value!;
      });
    }) ;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Profile",
        style: TextStyle(color:
        Colors.white,
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),
     drawer:Drawer(
       child: ListView(
         padding: EdgeInsets.symmetric(vertical: 50),
         children:<Widget> [
           Icon(Icons.account_circle,
             size: 150,
             color: Colors.grey[700],
           ),
           SizedBox(
             height: 15,
           ),
           Text(userName,textAlign: TextAlign.center,
             style: TextStyle(fontWeight: FontWeight.bold),),
           SizedBox(
             height: 30,
           ),
           Divider(
             height: 2,
           ),
           ListTile(
               onTap: (){

                 nextScreenReplace(context, HomePage());
               },

               selected:true,
               contentPadding:const EdgeInsets.symmetric(vertical: 5,horizontal: 50),
               leading: const Icon(Icons.group),
               title:const Text("Groups",
                 style: TextStyle(color: Colors.black),
               )

           ),
           ListTile(
               onTap: (){
                 nextScreenReplace(context, ProfilePage(userName:widget.userName, email:widget.email,));
               },
                 selected: true,
               selectedColor:Theme.of(context).primaryColor,
               contentPadding:const EdgeInsets.symmetric(vertical: 5,horizontal: 50),
               leading: const Icon(Icons.group),
               title:const Text("Profile",
                 style: TextStyle(color: Colors.black),
               )

           ),
           ListTile(
               onTap: (){
                 showDialog(
                     barrierDismissible: false
                     ,context: context, builder:(context){
                   return AlertDialog(
                     title: Text("logout"),
                     content: Text("Are you sure you want to logout?"),
                     actions: [
                       IconButton(onPressed:(){
                         Navigator.pop(context);
                       },
                           icon:Icon(Icons.cancel,color: Colors.red,)),
                       IconButton(
                           onPressed:() async {
                             authServices.signOut();
                             Navigator.of(context).pushAndRemoveUntil(
                                 MaterialPageRoute(builder: (context)=> LoginPage()),
                                     (route)=>false
                             );
                           },
                           icon:Icon(Icons.done,
                             color: Colors.green,))
                     ],
                   );
                 });

                 // authServices.signOut().whenComplete(() {
                 //  nextScreen(context, LoginPage()) ;
                 // });
               },

               contentPadding:const EdgeInsets.symmetric(vertical: 5,horizontal: 50),
               leading: const Icon(Icons.exit_to_app),
               title:const Text("Logout",
                 style: TextStyle(color: Colors.black),
               )

           )
         ],
       ),
     ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 170,horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget> [

            Icon(Icons.account_circle,
            size: 200,
              color: Colors.grey[700],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                const Text("Full Name",style: TextStyle(fontSize: 17,),),
                 Text(userName,style: TextStyle(fontSize: 17,),)
              ],
            ),
            const Divider( height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                const Text("Email",style: TextStyle(fontSize: 17,),),
                Text(email,style: TextStyle(fontSize: 17,),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
