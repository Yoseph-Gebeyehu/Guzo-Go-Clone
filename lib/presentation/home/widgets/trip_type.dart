import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TripType extends StatefulWidget {
  TripType({
    super.key,
    required this.deviceSize,
    required this.oneWay,
  });
  Size deviceSize;
  bool oneWay;

  @override
  State<TripType> createState() => _TripTypeState();
}

class _TripTypeState extends State<TripType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.deviceSize.width * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: widget.deviceSize.width * 0.45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.oneWay ? Colors.transparent : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.oneWay = false;
                });
              },
              child: Text(
                'Return',
                style: TextStyle(
                  color: widget.oneWay ? Colors.white : const Color(0xFF1f1b67),
                ),
              ),
            ),
          ),
          SizedBox(
            width: widget.deviceSize.width * 0.4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    !widget.oneWay ? Colors.transparent : Colors.white,
                elevation: 0,
              ),
              onPressed: () {
                setState(() {
                  widget.oneWay = true;
                });
              },
              child: Text(
                'One-Way',
                style: TextStyle(
                  color:
                      !widget.oneWay ? Colors.white : const Color(0xFF1f1b67),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
