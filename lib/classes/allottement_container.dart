import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/screens/alloted_booking.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AllottedContainer extends StatefulWidget {
  const AllottedContainer(
      {Key? key,
      required this.from,
      required this.to,
      required this.address,
      required this.cabtype,
      required this.triptype,
      required this.driverphonenumber,
      required this.fare,
      required this.total_fare,
      required this.driver_fee,
      required this.date,
      required this.time,
      required this.day,
      required this.docid,
      this.end_otp,
      this.user_id,
      required this.ride_id,
      required this.from_id,
      required this.to_id,
      required this.referred_by,
      this.distance,
      this.duration,
      required this.driver_name, required this.reward_points})
      : super(key: key);

  final String from;
  final String to;
  final String address;
  final String cabtype;
  final String triptype;
  final String driverphonenumber;
  final String date;
  final String time;
  final String day;
  final int fare;
  final int total_fare;
  final int driver_fee;
  final String docid;
  final String? end_otp;
  final String? user_id;
  final String ride_id;
  final String from_id;
  final String to_id;
  final String referred_by;
  final String? distance;
  final String? duration;
  final String driver_name;
  final int reward_points;
  @override
  _AllottedContainerState createState() => _AllottedContainerState();
}

class _AllottedContainerState extends State<AllottedContainer> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        shadowColor: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 10.0,
        child: Container(
          height: 260.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green, width: 1.5),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 7.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: widget.triptype == 'rental'? Text(
                  "${widget.from}-Rental",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.rubik(
                      color: Colors.green,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ):Text(
                  "${widget.from} to ${widget.to}",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.rubik(
                      color: Colors.green,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Text(
                      //       "${widget.from} to ${widget.to}",
                      //       style: GoogleFonts.rubik(
                      //           color: Colors.green,
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //   ],
                      // ),
                      //const SizedBox(height: 8.0,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Driver Name :" "${widget.driver_name}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Driver Ph.No:" "${widget.driverphonenumber}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Trip Type:" "${widget.triptype}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "Cab Type:" "${widget.cabtype}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            //padding: EdgeInsets.symmetric(vertical: 10.0),
                            width: 130.0,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        color: Colors.green,
                                      ),
                                      height: 20.0,
                                      width: 127.0,
                                      child: Center(
                                        child: Text(
                                          "Start Date",
                                          style: GoogleFonts.rubik(
                                              color: Colors.white,
                                              fontSize: 17.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.day,
                                      style: GoogleFonts.rubik(fontSize: 22.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.date,
                                      style: GoogleFonts.rubik(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.time,
                                      style: GoogleFonts.rubik(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   width: 50.0,
                  // ),
                ],
              ),
              const SizedBox(
                height: 14.0,
              ),
              const Divider(
                color: Colors.green,
                thickness: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.triptype == 'rental'
                        ? Column(
                            children: [
                              Text(
                                "Distance",
                                style: GoogleFonts.rubik(
                                    color: Colors.green, fontSize: 20.0),
                              ),
                              Text(
                                widget.distance!,
                                style: GoogleFonts.rubik(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                "Fare",
                                style: GoogleFonts.rubik(
                                    color: Colors.green, fontSize: 20.0),
                              ),
                              Text(
                                "${widget.fare}",
                                style: GoogleFonts.rubik(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                    widget.triptype == 'rental'
                        ? Column(
                            children: [
                              Text(
                                "Duration",
                                style: GoogleFonts.rubik(
                                    color: Colors.green, fontSize: 20.0),
                              ),
                              Text(
                                widget.duration!,
                                style: GoogleFonts.rubik(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                "Driver Fee",
                                style: GoogleFonts.rubik(
                                    color: Colors.green, fontSize: 20.0),
                              ),
                              Text(
                                "${widget.driver_fee}",
                                style: GoogleFonts.rubik(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                    Column(
                      children: [
                        Text(
                          "Total Fare",
                          style: GoogleFonts.rubik(
                              color: Colors.green, fontSize: 20.0),
                        ),
                        Text(
                          "${widget.total_fare}",
                          style: GoogleFonts.rubik(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.green,
                thickness: 1.5,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap:loading ?null: () async {
                      setState(() {
                        loading = true;
                      });
                      await _firestore
                          .collection(
                              'subscribed_users/${widget.driverphonenumber}/mytrips').doc(widget.ride_id)
                          .set({
                        'from': widget.from,
                        'to': widget.to,
                        'address': widget.address,
                        'triptype': widget.triptype,
                        'cabtype': widget.cabtype,
                        'time_stamp': FieldValue.serverTimestamp(),
                        'date': widget.date,
                        'day': widget.day,
                        'time': widget.time,
                        'fare': widget.fare,
                        'total_fare': widget.total_fare,
                        'driver_fee': widget.driver_fee,
                        'end_otp': widget.end_otp,
                        'user_id': widget.user_id,
                        'ride_id': widget.ride_id,
                        'from_id': widget.from_id,
                        'to_id': widget.to_id,
                        'referred_by': widget.referred_by,
                        'buttons_state': 0,
                        'distance': widget.distance,
                        'duration': widget.duration,
                        'reward_points':widget.reward_points
                      });
                      print('${widget.driverphonenumber}');
                      await _firestore.collection('allotted_booking').doc(widget.ride_id).set({
                        'from': widget.from,
                        'driver_phone_number': widget.driverphonenumber,
                        'to': widget.to,
                        'address': widget.address,
                        'triptype': widget.triptype,
                        'cabtype': widget.cabtype,
                        'time_stamp': FieldValue.serverTimestamp(),
                        'date': widget.date,
                        'day': widget.day,
                        'time': widget.time,
                        'fare': widget.fare,
                        'total_fare': widget.total_fare,
                        'driver_fee': widget.driver_fee,
                        'ride_id': widget.ride_id,
                        'from_id': widget.from_id,
                        'to_id': widget.to_id,
                        'referred_by': widget.referred_by,
                        'distance': widget.distance,
                        'duration': widget.duration,
                        'driver_name': widget.driver_name,
                        'reward_points':widget.reward_points
                      });
                      final car_name = await _firestore.collection('subscribed_users').doc(widget.driverphonenumber).get().then((value) => value['car_name']);
                      final car_number = await _firestore.collection('subscribed_users').doc(widget.driverphonenumber).get().then((value) => value['car_number']);
                      // _firestore.collection('profile').doc(widget.user_id).collection('trips').doc(widget.ride_id).set({'diver_accepted':1});
                       await _firestore
                          .collection('profile')
                          .doc(widget.user_id)
                          .collection('trips')
                          .doc(widget.ride_id)
                          .update({'driver_name': widget.driver_name,'driver_number':widget.driverphonenumber,'car_name':car_name,'car_number':car_number});
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllottedScreen()));
                      await _firestore
                          .collection('driveraccepted')
                          .doc(widget.docid)
                          .delete();
                    },
                    child: Container(
                      height: 35.0,
                      width: 100.0,
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
                            loading?SizedBox(child: CircularProgressIndicator()):
                            Text(
                              "Allot",
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
                  InkWell(
                    onTap: () async {
                      await _firestore
                          .collection('driveraccepted')
                          .doc(widget.docid)
                          .delete();
                      print(widget.docid);
                    },
                    child: Container(
                      height: 35.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Center(
                        child: Text(
                          "DECLINE",
                          style: GoogleFonts.rubik(
                              color: Colors.red,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // String telnumber = "";
                      FlutterPhoneDirectCaller.callNumber(
                          widget.driverphonenumber);
                    },
                    child: Container(
                      height: 35.0,
                      width: 100.0,
                      decoration: const BoxDecoration(

                          borderRadius:
                          BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.green),
                      child: Center(
                        child: Text(
                          "CALL",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
