import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? price;
  final int? quantity;
  final int? id;
  CartItem(
      {required this.image,
      required this.title,
      required this.price,
      required this.quantity,
      required this.id});

  @override
  Widget build(BuildContext context) {
    print(id);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Slidable(
          key: UniqueKey(),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                      '$quantity : Piece',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      title!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.network(
                      image!,
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
              color: Color(Constants.mainColor),
              icon: Icons.edit,
              onTap: () {
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (_) => SingleItemScreen(
                //           id: id!,
                //           title: title!,
                //           price: double.parse(price!),
                //           shopId: shopId,isEditable: true,)));
              },
            ),
            IconSlideAction(
              caption: 'ازالة',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                BlocProvider.of<CartCubit>(context)
                    .removeFromCart(productId: id);
              },
            ),
          ],
        ));
  }
}
