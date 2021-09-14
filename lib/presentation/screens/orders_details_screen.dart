import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/indigo_elevated_button.dart';

import '../../constants.dart';
import 'orders_screen.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                'assets/images/order status.gif',
                height: 0.32.sh,
                fit: BoxFit.fill,
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
                      stepColor: Colors.grey.shade50,
                      activeStepColor: Colors.grey.shade200,
                      lineColor: Color(0xff748A9D),
                      activeStepBorderWidth: 1.5,
                      lineLength: 50,
                      activeStepBorderColor: Colors.grey.shade500,
                      activeStep: 0,
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
                    ),
                  ),
                  Container(
                    height: 0.40.sh,
                    padding: EdgeInsets.symmetric(vertical: 0.028.sh),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('تم ارسال الطلب بنجاح'),
                            Text('152625#    10.20   13/12/2021')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('جاري تجهيز الطلب',
                                style: TextStyle(color: Colors.grey)),
                            Text(
                              '152625#    10.20   13/12/2021',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('جاري توصيل الطلب',
                                style: TextStyle(color: Colors.grey)),
                            Text(
                              '152625#    10.20   13/12/2021',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.08.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildElevatedButton(
                      title: 'تحديث',
                      function: () {},
                    ),
                    BuildElevatedButton(
                      title: 'طلباتي',
                      function: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => OrdersScreen()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
