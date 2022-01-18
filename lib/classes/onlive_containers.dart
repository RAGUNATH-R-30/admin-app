import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnLiveContainer extends StatefulWidget {
  const OnLiveContainer(
      {Key? key,
      required this.from,
      required this.to,
      required this.address,
      required this.cabtype,
      required this.triptype,
      required this.driverphonenumber,
      required this.date,
      required this.time,
      required this.day,
      required this.fare,
      required this.total_fare,
      required this.driver_fee,
      required this.ride_id,
        required this.distance,
        required this.duration, required this.driver_name})
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
  final String ride_id;
  final String distance;
  final String duration;
  final String driver_name;
  @override
  _OnLiveContainerState createState() => _OnLiveContainerState();
}

class _OnLiveContainerState extends State<OnLiveContainer> {
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
              // Row(
              //   children: [
              //     Text(
              //       "${widget.from} to ${widget.to}",
              //       overflow: TextOverflow.ellipsis,
              //       style: GoogleFonts.rubik(
              //           color: Colors.green,
              //           fontSize: 20.0,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ],
              // ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
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
                        "Driver Name :" "${widget.driver_name}",
                        style: GoogleFonts.rubik(
                          //letterSpacing: 2.0,
                          color: Colors.black,
                          fontSize: 18.0,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Driver Ph:No :" "${widget.driverphonenumber}",
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
                        "Cab Type:" "${widget.cabtype}",
                        style: GoogleFonts.rubik(
                          //letterSpacing: 2.0,
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: 130.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                color: Colors.green,
                              ),
                              height: 20.0,
                              width: 127.0,
                              child: Center(
                                child: Text(
                                  "Start Date",
                                  style: GoogleFonts.rubik(
                                      color: Colors.white, fontSize: 17.0),
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
                    widget.triptype =='rental'? Column(
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
                    ):Column(
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
                    widget.triptype =='rental'? Column(
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
                    ): Column(
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
                    )
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Fare",
                    //       style: GoogleFonts.rubik(
                    //           color: Colors.green, fontSize: 20.0),
                    //     ),
                    //     Text(
                    //       "${widget.fare}",
                    //       style: GoogleFonts.rubik(
                    //         color: Colors.black,
                    //         fontSize: 18.0,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Bata",
                    //       style: GoogleFonts.rubik(
                    //           color: Colors.green, fontSize: 20.0),
                    //     ),
                    //     Text(
                    //       "${widget.driver_fee}",
                    //       style: GoogleFonts.rubik(
                    //         color: Colors.black,
                    //         fontSize: 18.0,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Total Fare",
                    //       style: GoogleFonts.rubik(
                    //           color: Colors.green, fontSize: 20.0),
                    //     ),
                    //     Text(
                    //       "${widget.total_fare}",
                    //       style: GoogleFonts.rubik(
                    //         color: Colors.black,
                    //         fontSize: 18.0,
                    //       ),
                    //     )
                    //   ],
                    // )
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
            ],
          ),
        ),
      ),
    );
  }
}
