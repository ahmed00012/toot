import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/constants.dart';

class SingleChoiceDelivery extends StatefulWidget {
  final String title;
  final int index;
  final Function function;
  final List<bool> choicesList;
  final String? image;

  SingleChoiceDelivery(
      {required this.title,
      required this.index,
      required this.function,
      required this.choicesList,
      this.image});

  @override
  _SingleChoiceDeliveryState createState() => _SingleChoiceDeliveryState();
}

class _SingleChoiceDeliveryState extends State<SingleChoiceDelivery> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          widget.function(selected, widget.index);
        });
      },
      child: Container(
        height: 0.28.sh,
        width: 0.42.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                widget.image!,
                height: 0.1.sh,
              ),
              Text(
                widget.title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18.sp),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: widget.choicesList[widget.index] == true
                    ? Icon(
                        FontAwesomeIcons.solidCheckCircle,
                        size: 20.0,
                        color: Color(Constants.mainColor),
                      )
                    : Icon(
                        FontAwesomeIcons.solidCircle,
                        size: 20.0,
                        color: Colors.grey.shade100,
                      ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
