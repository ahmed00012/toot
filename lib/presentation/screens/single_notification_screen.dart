import 'package:flutter/material.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class SingleNotificationScreen extends StatelessWidget {
  const SingleNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'تنبيه جديد',
        isSearch: false,
        isLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0.04.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                    child: Image.asset(
                      'assets/images/notifications.png',
                      width: 1.sw,
                      height: 0.3.sh,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'تنيبه جديد',
                style: TextStyle(
                    color: Color(Constants.mainColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w100),
              ),
              Text(
                'عرض مميز يمكن الاستفاده منه الان',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
