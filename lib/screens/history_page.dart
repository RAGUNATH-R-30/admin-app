import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction History",
          style: GoogleFonts.rubik(),
        ),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('history').orderBy('time_stamp').snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<ListTile> listelements = [];
            final info = snapshot.data!.docs.reversed;
            for (var i in info) {
              listelements.add(
                  ListTile(
                title: Text(i['title'],style: GoogleFonts.rubik(fontSize: 20.0)),
                leading: Text(i['leading'],style: GoogleFonts.rubik(fontSize: 20.0)),
                subtitle: Text(i['sub_title'],style: GoogleFonts.rubik()),
                trailing: Text(i['trailing']+'₹',style: GoogleFonts.rubik(color: i['sub_title']=='Credited'?Colors.green:Colors.red,fontSize: 19.0),),


              ));
            }
            return ListView(
              children: listelements,
            );
          }),
    );
  }
}
