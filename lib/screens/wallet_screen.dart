import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/home_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController phone_number_controller = TextEditingController();
  TextEditingController amount_controller = TextEditingController();
  int amount = 0;

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
        title: Text("Wallet Screen"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const CircleAvatar(
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 60.0,
            ),
            backgroundColor: Colors.green,
            radius: 50.0,
          ),
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextField(
              controller: amount_controller,
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
                hintText: "Enter amount",
                hintStyle: GoogleFonts.ubuntu(color: Colors.green),
                fillColor: Colors.green[100],
                // labelText: "Phone.No",
                // labelStyle: GoogleFonts.ubuntu(color: Colors.green),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //credit
                InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        bool loading = true;
                        return StatefulBuilder(
                          builder: (context, state) => AlertDialog(
                            content: Container(
                              child: Text(
                                "Are You Sure You Want To \n\t    Credit To The Driver ?",
                                style: GoogleFonts.rubik(fontSize: 18.0),
                              ),
                            ),
                            // title: ,
                            actions: [
                              //okay
                              InkWell(
                                onTap: () async {
                                  if (phone_number_controller.text.isNotEmpty &&
                                      amount_controller.text.isNotEmpty) {
                                    state(() {
                                      loading = false;
                                    });

                                    final initial_amount = await _firestore
                                        .collection('subscribed_users')
                                        .doc(phone_number_controller.text)
                                        .get()
                                        .then((value) =>
                                            amount = value['wallet']);

                                    _firestore
                                        .collection('subscribed_users')
                                        .doc(phone_number_controller.text)
                                        .set({
                                      'wallet':
                                          int.parse(amount_controller.text) +
                                              initial_amount
                                    }, SetOptions(merge: true));

                                    _firestore
                                        .collection('subscribed_users')
                                        .doc(phone_number_controller.text)
                                        .collection('history')
                                        .add({
                                      'title': 'credited',
                                      'leading': DateTime.now()
                                          .toString()
                                          .split(" ")[0],
                                      'previous_balance':initial_amount,
                                      'trailing': '+' + amount_controller.text,
                                      'time_stamp': FieldValue.serverTimestamp()
                                    });

                                    await _firestore.collection('history').add({
                                      'title': phone_number_controller.text,
                                      'sub_title': 'Credited',
                                      'leading': DateTime.now()
                                          .toString()
                                          .split(" ")[0],
                                      'trailing': '+' + amount_controller.text,
                                      'time_stamp': FieldValue.serverTimestamp()
                                    });

                                    Navigator.pop(context);
                                  } else {
                                    showSnackBar("The Field is Empty");
                                  }
                                  Navigator.pop(context);
                                  // Navigator.pop(context);
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.green),
                                    child: Center(
                                      child: loading
                                          ? Text(
                                              "Okay",
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 22.0),
                                            )
                                          : SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              //cancel
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 22.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      //color: Colors.green
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Credit",
                            style: GoogleFonts.rubik(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //debit
                InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        bool loading = true;
                        return StatefulBuilder(
                          builder: (context, state) => AlertDialog(
                            content: Row(
                              children: [
                                Text(
                                  "Are You Sure You Want To \n\t    Debit To The Driver ?",
                                  style: GoogleFonts.rubik(fontSize: 18.0),
                                )
                              ],
                            ),
                            // title: ,
                            actions: [
                              InkWell(
                                onTap: () async {
                                  if (phone_number_controller.text.isNotEmpty &&
                                      amount_controller.text.isNotEmpty) {
                                    state(() {
                                      loading = false;
                                    });

                                    final initial_amount = await _firestore
                                        .collection('subscribed_users')
                                        .doc(phone_number_controller.text)
                                        .get()
                                        .then((value) =>
                                            amount = value['wallet']);

                                    _firestore
                                        .collection('subscribed_users')
                                        .doc(phone_number_controller.text)
                                        .set({
                                      'wallet': initial_amount -
                                          int.parse(amount_controller.text)
                                    }, SetOptions(merge: true));

                                    _firestore
                                        .collection('subscribed_users')
                                        .doc(phone_number_controller.text)
                                        .collection('history')
                                        .add({
                                      'title': 'Debited',
                                      'previous_balance':initial_amount,
                                      'leading': DateTime.now()
                                          .toString()
                                          .split(" ")[0],
                                      'trailing': '-' + amount_controller.text,
                                      'time_stamp': FieldValue.serverTimestamp()
                                    });

                                    await _firestore.collection('history').add({
                                      'title': phone_number_controller.text,
                                      'sub_title': 'Debited',
                                      'leading': DateTime.now()
                                          .toString()
                                          .split(" ")[0],
                                      'trailing': '-' + amount_controller.text,
                                      'time_stamp':
                                          FieldValue.serverTimestamp(),
                                    });
                                    print(auth.currentUser!.uid);
                                    print(phone_number_controller.text);

                                    Navigator.pop(context);
                                  } else {
                                    showSnackBar("The Field is Empty");
                                  }
                                  Navigator.pop(context);
                                  // Navigator.pop(context);
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.green),
                                    child: Center(
                                      child: loading
                                          ? Text(
                                              "Okay",
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 22.0),
                                            )
                                          : SizedBox(
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.white))),
                                    ),
                                  ),
                                ),
                              ),

                              //cancel
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 22.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      //color: Colors.green
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Debit",
                            style: GoogleFonts.rubik(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
