import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool subscribed_user_checker = false ;
final FirebaseAuth _auth = FirebaseAuth.instance;
class CheckBalance extends StatefulWidget {
  const CheckBalance({Key? key}) : super(key: key);

  @override
  _CheckBalanceState createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  TextEditingController phone_number_controller = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Check Balance",
          style: GoogleFonts.slabo13px(fontSize: 22.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextField(
              controller: phone_number_controller,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: GoogleFonts.ubuntu(fontSize: 20.0),
              keyboardType: TextInputType.number,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                filled: true,
                hintText: "Enter Phone Number",
                hintStyle: GoogleFonts.ubuntu(color: Colors.green),
                fillColor: Colors.green[100],
                // labelText: "Phone.No",
                // labelStyle: GoogleFonts.ubuntu(color: Colors.green),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
    await _firestore
        .collection('subscribed_users')
        .doc((phone_number_controller.text))
        .get()
        .then((value) {
    subscribed_user_checker =
    value.exists;
    });
    if(subscribed_user_checker){
              final driver_balance = await _firestore
                  .collection('subscribed_users')
                  .doc(phone_number_controller.text)
                  .get()
                  .then((value) => value['wallet']);
              print(driver_balance);

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Container(
                            height: 100.0,
                            width: 200.0,
                            child: Center(
                                child: Text(
                              "Balance Is ₹$driver_balance",
                              style: GoogleFonts.slabo13px(
                                  fontSize: 30, color: Colors.green),
                            )),
                          ),
                        ));
              }
    else{
      showSnackBar("Not An Subscribed User");
    }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.green),
                child: Center(
                  child: Text(
                    "Check Balance",
                    style:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 22.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
