import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  CartItem({required this.image, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Slidable(
          key: UniqueKey(),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            color: Colors.white,
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'تعديل',
              color: Colors.blue,
              icon: Icons.edit,
            ),
            IconSlideAction(
              caption: 'ازالة',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {},
            ),
          ],
        ));
  }
}
