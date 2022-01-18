import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/otpscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var phonenumbercontroller=TextEditingController();
  late String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool subscribed_user_checker = false ;
  void showSnackBar(String title) {
    final snackbar = SnackBar(
        content: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0)));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green,
      body: loading?const Center(child: CircularProgressIndicator(),):Column(
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
                        "Login",
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
                      controller: phonenumbercontroller,
                       style: GoogleFonts.ubuntu(fontSize: 18.0),
                      inputFormatters: [
                         FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
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
                          labelText: "Phone.No",
                          labelStyle: GoogleFonts.ubuntu(color: Colors.green)),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: ()async{
                      if (phonenumbercontroller.text.length != 10) {
                        showSnackBar("Enter The Valid Phone Number");
                      }
                      else {
                        setState(() {
                          loading=true;
                        });
                        await _auth.verifyPhoneNumber(
                            phoneNumber: "+91 "+phonenumbercontroller.text,
                            verificationCompleted:
                                (phoneAuthCredential) async {
                              setState(() {
                                loading=false;
                              });
                              await _auth.signInWithCredential(phoneAuthCredential);
                              await _firestore.collection('admine_phone_number').doc((_auth.currentUser!.phoneNumber!.substring(3))).get().then((value) {
                                subscribed_user_checker = value.exists;
                                print(_auth.currentUser!.phoneNumber);
                                print(subscribed_user_checker);
                                print(value.exists);
                                print(value.id);
                              });
                              if(subscribed_user_checker){
                                // setState(() {
                                //   loading = true;
                                // });
                                final token = await FirebaseMessaging.instance.getToken();
                                await _firestore.collection('admin_phone_number').doc(_auth.currentUser!.phoneNumber!.substring(3)).set({'token':token},SetOptions(merge: true));
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    HomePage()), (Route<dynamic> route) => false);
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) => const HomePage()));
                              }
                              else{
                                await _auth.signOut();
                                showSnackBar("You Are Not an Admin ");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                              }
                              // await _auth.signInWithCredential(phoneAuthCredential);
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              //     HomePage()), (Route<dynamic> route) => false);
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                            },
                            verificationFailed:
                                (verificationFailed) async {
                              setState(() {
                                loading=false;
                              });
                              print(verificationFailed.code);
                              if(verificationFailed.code=='too-many-requests') {
                                showSnackBar("Logged In Many Times please Login after 30 min");
                              }
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(verificationFailed.toString())));
                            },
                            codeSent: (verificationId,
                                resendingToken) async {
                              setState(() {
                                loading=false;
                                this.verificationId = verificationId;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    verificationid: verificationId,
                                  ),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout:
                                (verificationId) async {});
                      }
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpScreen()));
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
                          "Login",
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
