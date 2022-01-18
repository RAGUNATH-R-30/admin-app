import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/classes/completed_container.dart';
//import 'package:untitled1/classes/onlive_containers.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  _CompletedScreenState createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  String? getcurrentuser() {
    return auth.currentUser!.phoneNumber!.substring(3);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[400],
        title: Text("Completed Booking",style: GoogleFonts.ubuntu(),),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('completed_trips')
            .orderBy('time_stamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<CompletedContainer> completedcontainers = [];
          final info = snapshot.data!.docs;
          for (var i in info) {
            final from = i['from'];
            final to = i['to'];
            final address = i['address'];
            final triptype = i['triptype'];
            final cabtype = i['cabtype'];
            final driverfee = i['driver_fee'];
            final fare = i['fare'];
            final totalfare = i['total_fare'];
            final time = i['time'];
            final day = i['day'];
            final date = i['date'];
            final ride_id = i['ride_id'];
            final driver_name = i['driver_name'];
            final distance = i['distance'];
            final duration = i['duration'];
            final pickupvales = CompletedContainer(
              from: from,
              to: to,
              address: address,
              triptype: triptype,
              cabtype: cabtype,
              driverphonenumber: getcurrentuser()!,
              driver_fee: driverfee,
              fare: fare,
              total_fare: totalfare,
              time: time,
              day: day,
              date: date,
              ride_id: ride_id,
              driver_name: driver_name,
              distance: distance,
              duration: duration.toString(),
            );
            completedcontainers.add(pickupvales);
          }
          return ListView(
            children: completedcontainers,
          );
        },
      ),

    );
  }
}
