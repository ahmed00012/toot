import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/presentation/screens/single_item_screen.dart';

class CartItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? price;
  final int? quantity;
  final Function? function;
  final int? id;
  final int? shopId;
  final List? addons;
  final List? extra;
  bool? lastItem;
  CartItem(
      {required this.image,
      required this.title,
      required this.price,
      required this.quantity,
      this.function,
      required this.id,
      required this.shopId,
      this.extra,
      this.addons,
      this.lastItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Slidable(
          key: UniqueKey(),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${price.toString()} SR',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'العدد : $quantity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 0.25.sw,
                            child: Text(
                              title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.network(
                          image!,
                          width: 50.w,
                          height: 50.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text('الوزن', style: TextStyle(fontSize: 16)),
                      Spacer(),
                      extra == []
                          ? Text(
                              'لا يوجد',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          : Column(
                              children: extra!
                                  .map((e) => Text(e.optionvalue.nameAr))
                                  .toList(),
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text('الاضافات', style: TextStyle(fontSize: 16)),
                      Spacer(),
                      addons == []
                          ? Text(
                              'لا يوجد',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          : Column(
                              children: addons!
                                  .map((e) => Text(e.addon!.nameAr.toString()))
                                  .toList(),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'تعديل',
              color: Color(Constants.mainColor),
              icon: Icons.edit,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (_) => SingleItemScreen(
                              id: id!,
                              title: title!,
                              price: double.parse(price!),
                              shopId: shopId!,
                              isEditable: true,
                              removeFav: true,
                              isFav: true,
                            )))
                    .then((value) {
                  return function!();
                });
              },
            ),
            IconSlideAction(
              caption: 'ازالة',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                BlocProvider.of<CartCubit>(context)
                    .removeFromCart(productId: id, lastItem: lastItem);
              },
            ),
          ],
        ));
  }
}
