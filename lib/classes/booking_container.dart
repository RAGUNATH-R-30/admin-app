import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/screens/proceeded_booking.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class PickupContainer extends StatefulWidget {
  const PickupContainer(
      {Key? key,
      required this.from,
      required this.to,
      required this.address,
      required this.cabtype,
      required this.triptype,
      required this.ride_id,
      required this.date,
      required this.day,
      required this.time,
      required this.driver_fee,
      required this.fare,
      required this.total_fare,
      required this.docid,
      required this.trip_state,
      this.end_otp,
      required this.user_id,
      required this.from_id,
      required this.to_id,
      required this.referred_by,
      required this.customer_phone_number,
      required this.rental_state,
      required this.distance,
      required this.duration,
      required this.reward_points,
      this.booking_details})
      : super(key: key);

  final String from;
  final String to;
  final String address;
  final String cabtype;
  final String triptype;
  final String ride_id;
  final String date;
  final String day;
  final String time;
  final int driver_fee;
  final int fare;
  final int total_fare;
  final String docid;
  final int trip_state;
  final String? end_otp;
  final String user_id;
  final String from_id;
  final String to_id;
  final String referred_by;
  final String customer_phone_number;
  final bool rental_state;
  final String distance;
  final String duration;
  final int reward_points;
  final QueryDocumentSnapshot<Object?>? booking_details;

  @override
  _PickupContainerState createState() => _PickupContainerState();
}

class _PickupContainerState extends State<PickupContainer> {
  int kmfare = 0;
  void showSnackBar(String title) {
    final snackbar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 14.0),
        duration: Duration(seconds: 1),
        content: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0)));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  Future<int> fare_per_km(String trip_type,String car_mode)async{
    if(widget.triptype=='rental'){
      kmfare = await _firestore.collection('car_modes').doc(trip_type).get().then((value) => value.data()![car_mode]['fare_per_km']);
    }
    else{
      kmfare = await _firestore.collection('car_modes').doc(trip_type).get().then((value) => value.data()![car_mode]['fare']);
    }

    print(kmfare);
    return kmfare;
  }
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
          height: 350.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green, width: 1.5),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          border: Border.all(color: Colors.green)),
                      child: FutureBuilder<DocumentSnapshot>(
                        builder: (context, future) => future.hasData
                            ? Text(
                                future.data!['trip_status'],
                                style: GoogleFonts.rubik(
                                    fontSize: 22.0,
                                    color: (future.data!['trip_status'] ==
                                            'ongoing')
                                        ? Colors.orange
                                        : Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                            : SizedBox(

                                //child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
                                ),
                        future: _firestore
                            .collection('profile')
                            .doc(widget.user_id)
                            .collection('trips')
                            .doc(widget.ride_id)
                            .get(),
                      )),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: widget.triptype == 'rental'
                    ? Text(
                        "${widget.from}-Rental",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: GoogleFonts.rubik(
                            color: Colors.green,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500),
                      )
                    : Text(
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async{
                      print(widget.triptype);
                      await fare_per_km(widget.triptype, widget.cabtype);
                      if(widget.triptype=='rental'){
                        Clipboard.setData(ClipboardData(
                            text:
                            "\nFrom:${widget.from}\n"
                                // "\nTo:${widget.to}\n"
                                "\nTravel Date:${widget.date}\n"
                                "\nPickup Time:${widget.time}\n"
                                "\nVehicle Type:${widget.cabtype}\n"
                                "\nTrip Type:${widget.triptype}\n"
                                "\nEstimated Km:${widget.distance}\n"
                                "\nDriver Fee:${widget.driver_fee}\n"
                                "\nCustomer Phone Number:${widget.customer_phone_number}\n"
                                "\nFare Per Km:₹${kmfare}\n"
                                "\nEstimated Total Fare:${widget.total_fare}"
                        ));
                      }
                      else{
                        Clipboard.setData(ClipboardData(
                            text: "\nFrom:${widget.from}\n"
                                "\nTo:${widget.to}\n"
                                "\nTravel Date:${widget.date}\n"
                                "\nPickup Time:${widget.time}\n"
                                "\nVehicle Type:${widget.cabtype}\n"
                                "\nTrip Type:${widget.triptype}\n"
                                "\nEstimated Km:${widget.distance}\n"
                                "\nDriver Fee:${widget.driver_fee}\n"
                                "\nCustomer Phone Number:${widget.customer_phone_number}\n"
                                "\nFare Per Km:₹${kmfare}\n"
                                "\nEstimated Total Fare:${widget.total_fare}"));
                      }
                      showSnackBar("Copied");
                    },
                    child: Icon(
                      Icons.copy,
                      size: 28.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 3.0,
              // ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 14.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(height: 12.0,),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ride Id :" "${widget.ride_id}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Trip Type:" " ${widget.triptype}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "Cab Type:" " ${widget.cabtype}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "Customer-Ph.No-",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                " ${widget.customer_phone_number}",
                                style: GoogleFonts.rubik(
                                  //letterSpacing: 2.0,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 40.0,
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
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(
                color: Colors.green,
                thickness: 1.5,
              ),
              // if(widget.rental_state)
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
                                widget.distance,
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
                              FutureBuilder<int>(builder:(context,future) {
                                if(future.hasData){
                                    return Text(
                                      "₹"+future.data.toString(),
                                      style: GoogleFonts.rubik(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),
                                    );
                                  }
                                else{
                                  return CircularProgressIndicator();
                                }
                                },
                                future: fare_per_km(widget.triptype, widget.cabtype),
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
                                widget.duration,
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
                          "Est.Total Fare",
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
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.green,
                thickness: 1.5,
              ),
              // const SizedBox(
              //   height: 8.0,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: loading
                            ? null
                            : () async {
                                setState(() {
                                  loading = true;
                                });
                                await _firestore
                                    .collection('proceded')
                                    .doc(widget.ride_id)
                                    .set({
                                  'from': widget.from,
                                  'to': widget.to,
                                  'address': widget.address,
                                  'triptype': widget.triptype,
                                  'cabtype': widget.cabtype,
                                  'time_stamp': FieldValue.serverTimestamp(),
                                  'fare': widget.fare,
                                  'driver_fee': widget.driver_fee,
                                  'total_fare': widget.total_fare,
                                  'date': widget.date,
                                  'day': widget.day,
                                  'time': widget.time,
                                  'driveraccepted': widget.trip_state,
                                  'end_otp': widget.end_otp,
                                  'user_id': widget.user_id,
                                  'ride_id': widget.ride_id,
                                  'from_id': widget.from_id,
                                  'to_id': widget.to_id,
                                  'referred_by': widget.referred_by,
                                  'distance': widget.distance,
                                  'duration': widget.duration,
                                  'reward_points': widget.reward_points
                                });
                                // print("from${widget.from}to ${widget.to}");
                                showSnackBar('Sent to driver');

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProceededBooking()));

                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProceededBooking()));
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
                                loading
                                    ? SizedBox(
                                        child: CircularProgressIndicator())
                                    : Text(
                                        "PROCEED",
                                        style: GoogleFonts.rubik(
                                            color: Colors.green,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          final Map<String, dynamic> book_det =
                              widget.booking_details!.data()
                                  as Map<String, dynamic>;

                          await _firestore
                              .collection('cancelled_trips')
                              .doc(widget.ride_id)
                              .set(book_det);
                          await _firestore
                              .collection('new_booking')
                              .doc(widget.docid)
                              .delete();
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
                              "CANCEL",
                              style: GoogleFonts.rubik(
                                  color: Colors.red,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          // String telnumber = "";
                          FlutterPhoneDirectCaller.callNumber(
                              widget.customer_phone_number);
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
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          await _firestore
                              .collection('profile')
                              .doc(widget.user_id)
                              .update({'disabled': true});
                          await _firestore
                              .collection('new_booking')
                              .doc(widget.ride_id)
                              .delete();
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
                              "FAKE",
                              style: GoogleFonts.rubik(
                                  color: Colors.red,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
