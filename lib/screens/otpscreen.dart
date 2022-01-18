import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/home_screen.dart';

import 'login_screen.dart';



class OtpScreen extends StatefulWidget {
  final String verificationid;
  const OtpScreen({Key? key,required this.verificationid,}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading =false;
  void showSnackBar(String title) {
    final snackbar = SnackBar(
        content: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0)));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  void signinwithcredential(PhoneAuthCredential phoneAuthCredential) async{
    bool subscribed_user_checker = false ;
    setState(() {
      loading=true;
    });
    try{
      final authcredential= await _auth.signInWithCredential(phoneAuthCredential);
      await _firestore.collection('admine_phone_number').doc((_auth.currentUser!.phoneNumber!.substring(3))).get().then((value) {
        subscribed_user_checker = value.exists;
        print(_auth.currentUser!.phoneNumber);
        print(subscribed_user_checker);
        print(value.exists);
        print(value.id);
      });
      if(subscribed_user_checker){
        if (authcredential.user != null) {
          // setState(() {
          //   loading = false;
          // });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
      else{
        await _auth.signOut();
        showSnackBar("You Are Not an Admin");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    }on FirebaseAuthException catch(e){
      setState(() {
        loading=false;
      });
      showSnackBar(e.code.toString());
    }

  }
  final otpcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green,
      body: loading? const Center(child: CircularProgressIndicator(),):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
            radius: 60.0,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 80.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 12.0,
              shadowColor: Colors.greenAccent,
              borderRadius: BorderRadius.circular(12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter Otp",
                        style: GoogleFonts.ubuntu(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: otpcontroller,
                      style: GoogleFonts.ubuntu(fontSize: 18.0),
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: Colors.grey[300],
                          labelText: "Enter The Otp",
                          labelStyle: GoogleFonts.ubuntu(color: Colors.green)),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: ()async{
                      setState(() {
                        loading=true;
                      });
                      PhoneAuthCredential phoneAuthCredential=PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpcontroller.text);
                      signinwithcredential(phoneAuthCredential);
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.green,
                      ),
                      height: 55.0,
                      width: 190.0,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
