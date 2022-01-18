import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:untitled1/classes/allottement_container.dart';
import 'package:untitled1/classes/onlive_containers.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AllottedScreen extends StatefulWidget {
  const AllottedScreen({Key? key}) : super(key: key);

  @override
  _AllottedScreenState createState() => _AllottedScreenState();
}

class _AllottedScreenState extends State<AllottedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[400],
        title: Text(
          "Allotted Booking",
          style: GoogleFonts.ubuntu(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('allotted_booking')
                .orderBy('time_stamp', descending: true)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<OnLiveContainer> onlivecontainers = [];
              final info = snapshot.data!.docs;
              for (var i in info) {
                // final from = i['from'];
                // final to = i['to'];
                // final address = i['address'];
                // final triptype = i['triptype'];
                // final cabtype = i['cabtype'];
                // final driverphonenumber = i['driver_phone_number'];
                // final fare = i['fare'];
                // final total_fare = i['total_fare'];
                // final driverfee = i['driver_fee'];
                // final date = i['date'];
                // final time = i['time'];
                // final day = i['day'];
                print(i['ride_id']);
                final pickupvales = OnLiveContainer(
                  from: i['from'],
                  to: i['to'],
                  address: i['address'],
                  triptype: i['triptype'],
                  cabtype: i['cabtype'],
                  driverphonenumber: i['driver_phone_number'],
                  fare: i['fare'],
                  total_fare: i['total_fare'],
                  driver_fee:i['driver_fee'],
                  date: i['date'],
                  time: i['time'],
                  day: i['day'],
                  ride_id: i['ride_id'],
                  duration: i['duration'],
                  distance: i['distance'],
                  driver_name: i['driver_name'],
                );

                onlivecontainers.add(pickupvales);
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: onlivecontainers.length,
                  itemBuilder: (context, index) =>
                      onlivecontainers.elementAt(index),
                ),
              );
            },

            // builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            //   // if(snapshot.hasData){
            //   //   final info = snapshot.data!.docs;
            //   //   for(var i in info){
            //   //
            //   //   }
            //   //
            //   // }
            // },
          )
          // AllottedContainer(),
          // AllottedContainer(),
          // AllottedContainer(),
        ],
      ),
    );
  }
}
