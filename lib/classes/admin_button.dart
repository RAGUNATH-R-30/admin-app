import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AdminButton extends StatefulWidget {
  const AdminButton({
    Key? key,required this.text,required this.ontap,
  }) : super(key: key);
  final String text;
  final VoidCallback ontap;
  @override
  State<AdminButton> createState() => _AdminButtonState();
}

class _AdminButtonState extends State<AdminButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        elevation: 18.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.green,
          ),
          //height: 0.0,
          width: 190.0,
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}