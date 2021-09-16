import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/constants.dart';
import 'package:toot/presentation/widgets/cart_item.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/delivery_app_bar.dart';
import 'package:toot/presentation/widgets/discount_modal_bottom_sheet.dart';

import 'order_confirmation.dart';

class OrderSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: BuildDeliveryBar(
          title: 'ملخص الطلب',
          isSummary: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  CartItem(
                    title: 'Broccoli',
                    image: 'assets/images/cart (2).png',
                    price: 3.00,
                  ),
                  CartItem(
                    title: 'Kale',
                    image: 'assets/images/cart (3).png',
                    price: 1.50,
                  ),
                  CartItem(
                    title: 'Red Peppers',
                    image: 'assets/images/cart (1).png',
                    price: 4.00,
                  ),
                  CartItem(
                    title: 'Strawberries',
                    image: 'assets/images/cart (4).png',
                    price: 21.00,
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('احصل علي خصم مع طلبك'),
                    GestureDetector(
                      onTap: () => discountModalBottomSheetMenu(context),
                      child: Text(
                        'اضافة رمز ترويجي',
                        style: TextStyle(color: Color(Constants.mainColor)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع الفرعي',
                      style: TextStyle(
                          fontSize: 16.sp, color: Colors.blueGrey.shade400),
                    ),
                    Text('SR  9.30',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blueGrey.shade400,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الضريبة',
                      style: TextStyle(
                          fontSize: 16.sp, color: Colors.blueGrey.shade400),
                    ),
                    Text('SR  9.30',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blueGrey.shade400,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'التوصيل',
                      style: TextStyle(
                          fontSize: 16.sp, color: Colors.blueGrey.shade400),
                    ),
                    Text('SR  1.30',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blueGrey.shade400,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Color(Constants.mainColor),
                      ),
                    ),
                    Text('SR  9.30',
                        style: TextStyle(
                            fontSize: 22.sp,
                            color: Color(Constants.mainColor),
                            fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              BuildIndigoButton(
                  title: 'اتمام الطلب',
                  function: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => OrderConfirmationScreen()),
                    );
                  }),
              SizedBox(
                height: 0.05.sh,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
