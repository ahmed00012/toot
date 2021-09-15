import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/screens/orders_details_screen.dart';
import 'package:toot/presentation/screens/orders_screen.dart';
import 'package:toot/presentation/widgets/indigo_elevated_button.dart';
import '../../constants.dart';

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/graphic-confirmation.png',
                height: 0.65.sw,
                width: 0.65.sw,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 0.07.sh,
              ),
              Text(
                ' تم تنفيذ الطلب رقم طلبك هو',
                style: TextStyle(fontSize: 24.sp, color: Colors.grey.shade600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OrdersDetailsScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '#5678',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Color(Constants.mainColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildElevatedButton(
                    title: 'حالة الطلب الحالي',
                    function: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => OrdersDetailsScreen()));
                    },
                  ),
                  BuildElevatedButton(
                    title: 'طلباتي',
                    function: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => OrdersScreen()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}