import 'package:flutter/material.dart';
import 'package:toot/constants.dart';
import 'package:toot/presentation/screens/single_notification_screen.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'تنبيهات',
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0.03.sh),
        children: [
          BuildNotificationItem(
            image: 'assets/images/notifications.png',
            title: 'تنبيه جديد',
            details: 'عرض مميز يمكن الاستفادة منه الان',
          ),
          BuildNotificationItem(
            image: 'assets/images/notifications 2.png',
            title: 'تنبيه جديد ',
            details: 'عرض مميز يمكن الاستفادة منه الان',
          ),
        ],
      ),
    );
  }
}

class BuildNotificationItem extends StatelessWidget {
  final String title;
  final String details;
  final String image;
  BuildNotificationItem(
      {required this.title, required this.image, required this.details});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SingleNotificationScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 0.4.sh,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  child: Image.asset(
                    image,
                    width: 1.sw,
                    height: 0.3.sh,
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.03.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Color(Constants.mainColor),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    details,
                    style: TextStyle(color: Colors.grey.shade500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
