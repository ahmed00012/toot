import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';

import 'delivery_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'السله',
        isSearch: false,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
        child: Column(
          children: [
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المجموع الفرعي',
                    style: TextStyle(
                        fontSize: 16.sp, color: Colors.blueGrey.shade400),
                  ),
                  Text('£9.30',
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
                  Text('£1.30',
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
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                  Text('£9.30',
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.blueGrey.shade400,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            SizedBox(
              height: 0.05.sh,
            ),
            BuildIndigoButton(
                title: 'الدفع',
                function: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DeliveryAddressesScreen()));
                }),
            SizedBox(
              height: 0.05.sh,
            ),
          ],
        ),
      )),
    );
  }
}

class CartItem extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  CartItem({required this.image, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Dismissible(
        key: UniqueKey(),
        background: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 0.2.sw,
              decoration: BoxDecoration(
                  color: Color(0xffA6BCD0),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 30,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
            ),
            Container(
              width: 0.2.sw,
              color: Color(0xffDBE2ED),
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              // alignment: Alignment.centerRight,
              // padding: EdgeInsets.only(right: 20),
            ),
          ],
        ),
        direction: DismissDirection.startToEnd,
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 0.1.sh,
          decoration: BoxDecoration(
              color: Color(0xffF0F4F8),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${price.toString()} RS',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    '2 : Piece',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    image,
                    width: 60.w,
                    height: 60.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
