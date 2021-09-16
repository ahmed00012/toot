import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

void discountModalBottomSheetMenu(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12.0),
            topRight: const Radius.circular(12.0)),
      ),
      builder: (builder) {
        return new Container(
          padding: EdgeInsets.only(top: 0.02.sh, left: 12, right: 12),
          height: 0.38.sh,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 0.25.sw,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.04.sh),
                child: Text('استخدم قسمية الشراء',
                    style: TextStyle(fontSize: 20.sp)),
              ),
              TextField(
                style: TextStyle(fontSize: 20.sp),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Color(0xffF0F4F8),
                  hintText: 'اضافة رمز ترويجي',
                  prefixIcon: Icon(
                    FontAwesomeIcons.gift,
                    size: 25,
                    color: Color(Constants.mainColor),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 16.sp, color: Color(Constants.mainColor)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 0.04.sh,
              ),
              SizedBox(
                width: 1.sw,
                height: 0.07.sh,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('استخدام الرمز'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(Constants.mainColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
