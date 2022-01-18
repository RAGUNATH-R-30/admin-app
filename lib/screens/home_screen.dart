import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clipboard/clipboard.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/add_new_driver.dart';
import 'package:untitled1/screens/alloted_booking.dart';
import 'package:untitled1/screens/completed_booking.dart';
import 'package:untitled1/screens/history_page.dart';
import 'package:untitled1/screens/manual_screen.dart';
import 'package:untitled1/screens/new_booking.dart';
import 'package:untitled1/screens/proceeded_booking.dart';

//import 'package:untitled1/classes/allottement_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/classes/admin_button.dart';
import 'package:untitled1/screens/wallet_screen.dart';

import 'check_balance_screen.dart';
import 'login_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth= FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Container(),
        title: Text(
          "Admin",
          style:
              GoogleFonts.ubuntu(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [InkWell(
          onTap: ()async{
            await _auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          },
            child: Icon(Icons.logout))
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: [
//manual
//           AdminButton(
//             text: "Manual Booking",
//             ontap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const ManualPage()));
//             },
          //),
//new booking
          AdminButton(
            text: 'New    Booking',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewBookingPage(),
                ),
              );
            },
          ),
//proceeded booking
          AdminButton(
            text: 'Proceeded Boooking',
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProceededBooking()));
            },
          ),
//allotted booking
          AdminButton(
            text: 'Allotted Booking',
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllottedScreen()));
            },
          ),
//completed booking
          AdminButton(
            text: 'Completed Booking',
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompletedScreen()));
            },
          ),

          //new driver
          AdminButton(
            text: 'Add New Driver',
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewDriver()));
            },
          ),

          //wallet
          AdminButton(
            text: 'Wallet',
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WalletScreen()));
            },
          ),
          //history
          AdminButton(
            text: 'History',
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
          ),
          //checkbalance
          AdminButton(
            text: 'Check Balance',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckBalance(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void getcurrentuser() {
    final User? user = auth.currentUser;
    final userphonenumber = user!.phoneNumber;
    // print(userphonenumber);
  }
}

// Scaffold(
// appBar: AppBar(
// backgroundColor: Colors.green,
// leading: Container(),
// title: Text(
// "Admin",
// style:
// GoogleFonts.ubuntu(fontSize: 30.0, fontWeight: FontWeight.bold),
// ),
// centerTitle: true,
// ),
// body: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,

// ),
// )
