import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class OrdersDetailsScreen extends StatefulWidget {
  @override
  _OrdersDetailsScreenState createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BuildAppBar(
        title: 'حالة الطلب',
        isBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'assets/images/delivery.png',
              fit: BoxFit.cover,
            )),
            SizedBox(
              height: 0.08.sh,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.2.sw,
                  height: 0.40.sh,
                  child: IconStepper(
                    enableStepTapping: false,
                    stepColor: Colors.grey.shade200,
                    lineColor: Color(0xff748A9D),
                    lineLength: 55,
                    scrollingDisabled: true,
                    direction: Axis.vertical,
                    enableNextPreviousButtons: false,
                    icons: [
                      Icon(
                        Icons.shopping_cart,
                        color: Color(Constants.mainColor),
                      ),
                      Icon(
                        Icons.settings,
                        color: Color(Constants.mainColor),
                      ),
                      Icon(
                        Icons.delivery_dining,
                        color: Color(Constants.mainColor),
                      ),
                    ],
                    activeStep: 3,
                  ),
                ),
                Container(
                  height: 0.38.sh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text('تم ارسال الطلب بنجاح'),
                          Text('152625#    10.20   13/12/2021')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('جاري تجهيز الطلب'),
                          Text('152625#    10.20   13/12/2021')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('جاري توصيل الطلب'),
                          Text('152625#    10.20   13/12/2021')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
