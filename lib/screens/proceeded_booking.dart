import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/classes/allottement_container.dart';
import 'package:untitled1/screens/home_screen.dart';

//import 'package:untitled1/classes/booking_container.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProceededBooking extends StatefulWidget {
  const ProceededBooking({Key? key}) : super(key: key);

  @override
  _ProceededBookingState createState() => _ProceededBookingState();
}

class _ProceededBookingState extends State<ProceededBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        //   },
        //   child: Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        title: Text(
          "Proceeded Booking",
          style: GoogleFonts.ubuntu(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('driveraccepted')
                .orderBy('time_stamp', descending: true)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<AllottedContainer> allotedcontainers = [];
              final info = snapshot.data!.docs;
              for (var i in info) {
                // final docid = i.id;
                // final from = i['from'];
                // final to = i['to'];
                // final address = i['address'];
                // final triptype = i['triptype'];
                // final cabtype = i['cabtype'];
                // final driverphonenumber = i['driverphonenumber'];
                // final fare = i['fare'];
                // final total_fare = i['total_fare'];
                // final driverfee = i['driver_fee'];
                // final date = i['date'];
                // final time = i['time'];
                // final day = i['day'];
                // final end_otp = i['end_otp'];
                // final user_id = i['user_id'];
                // final ride_id = i['ride_id'];
                // final from_id = i['from_id'];
                // final to_id = i['to_id'];
                // final referred_by = i['referred_by'];

                final pickupvales = AllottedContainer(
                  from: i['from'],
                  to: i['triptype']== 'rental'?'':i['to'],
                  address: i['address'],
                  triptype: i['triptype'],
                  cabtype: i['cabtype'],
                  driverphonenumber: i['driverphonenumber'],
                  fare: i['triptype']== 'rental'?0:i['fare'],
                  date: i['date'],
                  day: i['day'],
                  total_fare: i['total_fare'],
                  driver_fee: i['triptype']== 'rental'?0:i['driver_fee'],
                  time: i['time'],
                  docid: i.id,
                  end_otp: i['end_otp'],
                  user_id: i['user_id'],
                  ride_id: i['ride_id'],
                  from_id: i['from_id'],
                  to_id: i['triptype'] == 'rental'?'':i['to_id'],
                  referred_by: i['referred_by'],
                  distance: i['triptype']== 'rental'?i['distance']:'',
                  duration: i['triptype'] == 'rental'?i['duration']:'',
                  driver_name: i['driver_name'],
                  reward_points: i['reward_points'],
                );
                allotedcontainers.add(pickupvales);
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: allotedcontainers.length,
                  itemBuilder: (context, index) =>
                      allotedcontainers.elementAt(index),
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
