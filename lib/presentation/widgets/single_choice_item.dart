import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/constants.dart';

class SingleChoiceItem extends StatefulWidget {
  final String title;
  final int index;
  final Function function;
  final List<bool> choicesList;

  SingleChoiceItem({
    required this.title,
    required this.index,
    required this.function,
    required this.choicesList,
  });

  @override
  _SingleChoiceItemState createState() => _SingleChoiceItemState();
}

class _SingleChoiceItemState extends State<SingleChoiceItem> {
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
        padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 0.1.sh,
        decoration: BoxDecoration(
          color: widget.choicesList[widget.index] == true
              ? Color(Constants.mainColor)
              : Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: widget.choicesList[widget.index] == true
                    ? Colors.white
                    : Colors.grey.shade600,
                fontSize: 18.sp,
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: widget.choicesList[widget.index] == true
                  ? Icon(
                      FontAwesomeIcons.solidCheckCircle,
                      size: 25.0,
                      color: Colors.white,
                    )
                  : Icon(
                      FontAwesomeIcons.solidCircle,
                      size: 25.0,
                      color: Colors.grey.shade300,
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
