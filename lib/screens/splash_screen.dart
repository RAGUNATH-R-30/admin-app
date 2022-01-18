import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'new_booking.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void getcurrentuser() async{

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseMessaging.instance.subscribeToTopic('admine');

    final User? user = auth.currentUser;
    setState(() {
      user!=null?screen_bool = 1:screen_bool=0;
    });


    widgetreturner();

  }
  void  widgetreturner(){
    if(screen_bool == 0){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
    else if(screen_bool == 1){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
  }
  int screen_bool = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print(userphonenumber);
    getcurrentuser();

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
