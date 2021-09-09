import 'package:flutter/material.dart';
import 'package:toot/constants.dart';
import 'package:toot/presentation/screens/orders_details._screen.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'طلباتك',
        isLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              OrderItem(),
              OrderItem(),
              OrderItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatefulWidget {
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExtended = !isExtended;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: isExtended ? 0.4.sh : 0.09.sh,
        width: 0.95.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xffF0F4F8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #5678',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                  Icon(
                      isExtended
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey.shade600)
                ],
              ),
              isExtended
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CUPCAKE',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                              Text(
                                'SR 0.80',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CUPCAKE',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                              Text(
                                'SR 0.80',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CUPCAKE',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                              Text(
                                'SR 0.80',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CUPCAKE',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                              Text(
                                'SR 0.80',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => OrdersDetailsScreen()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Shipped',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 0.08.sw,
                                    width: 0.08.sw,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(Constants.mainColor)),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'SR  4.99',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Delivery',
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'SR 14.29',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 20.sp),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 20.sp),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
