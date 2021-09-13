import 'package:flutter/material.dart';
import 'package:toot/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';

class AddDeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'اضافة عنوان',
            style: TextStyle(
                color: Color(Constants.mainColor), fontWeight: FontWeight.w300),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: Color(Constants.mainColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey.shade50,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.05.sh),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'العنوان',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(Constants.mainColor), width: 0.8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Color(Constants.mainColor), width: 0.8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Text(
                  'ملاحظات التوصيل',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(Constants.mainColor), width: 0.8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Color(Constants.mainColor), width: 0.8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.3.sh,
                ),
                Center(
                  child: BuildIndigoButton(
                      title: 'اضافة',
                      function: () {
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
