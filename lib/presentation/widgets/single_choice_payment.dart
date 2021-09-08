import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/constants.dart';
import 'package:toot/presentation/screens/add_visa_screen.dart';

class SingleChoicePayment extends StatefulWidget {
  final String title;
  final int index;
  final Function function;
  final List<bool> choicesList;
  final IconData icon;
  final bool? isVisa;

  SingleChoicePayment(
      {required this.title,
      required this.index,
      required this.function,
      required this.choicesList,
      required this.isVisa,
      required this.icon});

  @override
  _SingleChoicePaymentState createState() => _SingleChoicePaymentState();
}

class _SingleChoicePaymentState extends State<SingleChoicePayment> {
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
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 20,
            color: widget.choicesList[widget.index] == true
                ? Color(Constants.mainColor)
                : Colors.grey.shade600,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddVisaScreen()));
            },
            child: Text(
              widget.title,
              style: TextStyle(
                  color: widget.choicesList[widget.index] == true
                      ? Color(Constants.mainColor)
                      : Colors.grey.shade600,
                  fontSize: 18.sp,
                  decoration: widget.isVisa!
                      ? TextDecoration.underline
                      : TextDecoration.none),
            ),
          ),
          Spacer(),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: widget.choicesList[widget.index] == true
                ? Icon(
                    FontAwesomeIcons.solidCheckCircle,
                    size: 25.0,
                    color: Color(Constants.mainColor),
                  )
                : Icon(
                    FontAwesomeIcons.solidCircle,
                    size: 25.0,
                    color: Colors.grey.shade300,
                  ),
          )),
        ],
      ),
    );
  }
}
