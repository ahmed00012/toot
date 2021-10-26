import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/data/models/last_order.dart';
import 'package:toot/presentation/screens/orders_details_screen.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).fetchLastOrders();
    return Scaffold(
      appBar: BuildAppBar(
        title: 'طلباتك',
        isBack: false,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is LastOrdersLoaded) {
            final orders = state.orders;
            return ListView.builder(
                itemCount: orders.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) => OrderItem(
                      id: orders[index].id!,
                      cart: orders[index].cart!,
                      function: () async {
                        setState(() {});
                      },
                    ));
          } else {
            return Center(
                child: Container(
              height: 120,
              width: 120,
              child: Lottie.asset('assets/images/lf20_j1klguuo.json'),
            ));
          }
        },
      ),
    );
  }
}

class OrderItem extends StatefulWidget {
  final int id;
  final Cart cart;
  final Function function;

  OrderItem({required this.id, required this.cart, required this.function});

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
        margin: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.03.sh),
        width: 0.95.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xffF0F4F8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' طلب #${widget.id}',
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
                        ...widget.cart.items!
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.productName!,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'SR ${e.price}',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
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
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => OrdersDetailsScreen(
                                      id: widget.id,
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  return widget.function();
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.cart.status!.name!,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
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
                                      'SR  ${widget.cart.deliveryFee}',
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
                                      'SR ${widget.cart.total}',
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
