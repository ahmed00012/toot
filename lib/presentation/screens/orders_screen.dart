import 'package:flutter/material.dart';
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            OrderItem()
          ],
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: isExtended ? 0.09.sh : 0.3.sh,
        width: 0.95.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xffF0F4F8)),
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CUPCAKE',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                  Text(
                    'SR 0.80',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CUPCAKE',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                  Text(
                    'SR 0.80',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CUPCAKE',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                  Text(
                    'SR 0.80',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CUPCAKE',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                  Text(
                    'SR 0.80',
                    style:
                        TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
