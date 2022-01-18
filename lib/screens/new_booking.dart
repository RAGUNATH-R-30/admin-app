import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/classes/booking_container.dart';
import 'package:untitled1/screens/home_screen.dart';

class NewBookingPage extends StatefulWidget {
  const NewBookingPage({Key? key}) : super(key: key);

  @override
  _NewBookingPageState createState() => _NewBookingPageState();
}

class _NewBookingPageState extends State<NewBookingPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[400],
        title: Text(
          "New Booking",
          style: GoogleFonts.ubuntu(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('new_booking')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<PickupContainer> pickupcontainers = [];
              final info = snapshot.data!.docs;
              bool rental_state = false;
              String distance = '';
              String duration ='';
              int fare = 0;
              int driverfee = 0;
              String to ='';
              String to_id = '';
              for (var trip in info) {
                final pickupvales = PickupContainer(
                  from: trip['from_location'],
                  to: trip['trip_type'] == 'rental'?'':trip['to_location'],
                  address: trip['from_address'],
                  triptype: trip['trip_type'],
                  cabtype: trip['car_mode'],
                  ride_id: trip['booking_id'],
                  date: trip['trip_start_date'],
                  day: trip['day'],
                  time: trip['time'],
                  fare: trip['trip_type'] == 'rental'?0:trip['base_fare'],
                  driver_fee: trip['trip_type'] == 'rental'?0:trip['driver_fee'],
                  total_fare: trip['total_fare'],
                  docid: trip.id,
                  trip_state: trip['driver_accepted'],
                  end_otp: trip['otp'],
                  user_id: trip['user_id'],
                  referred_by: trip['referred_by'],
                  to_id: trip['trip_type'] == 'rental'?'':trip['to_id'],
                  from_id: trip['from_id'],
                  customer_phone_number: trip['phone_number'],
                  rental_state: rental_state,
                  distance: trip['distance'],
                  duration: trip['trip_type'] == 'rental'?trip['duration']:'',
                  reward_points: trip['reward_points'],
                  booking_details: trip,
                );
                pickupcontainers.add(pickupvales);
              }
              return Expanded(
                child: ListView(
                  children: pickupcontainers,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
