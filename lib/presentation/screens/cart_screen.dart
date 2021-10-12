import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/presentation/widgets/cart_item.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';

import '../../constants.dart';
import 'delivery_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'السله',
        isBack: false,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cartDetails = state.cartDetails;
            print(cartDetails.data!.items![0].vendorId);
            return Padding(
              padding:
                  EdgeInsets.only(right: 0.06.sw, left: 0.06.sw, top: 0.02.sh),
              child: Column(
                children: [
                  Container(
                    height: 0.46.sh,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: cartDetails.data!.items!.length,
                      itemBuilder: (context, index) => CartItem(
                        title: cartDetails.data!.items![index].productName,
                        image: cartDetails.data!.items![index].productImage,
                        price: cartDetails.data!.items![index].price,
                        quantity: cartDetails.data!.items![index].count,
                        id: cartDetails.data!.items![index].productId,
                        shopId: cartDetails.data!.items![index].vendorId,
                        function: () {
                          BlocProvider.of<CartCubit>(context)
                              .emit(CartLoaded(cartDetails: cartDetails));
                        },
                      ),
                    ),
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
                        Text('SR ${cartDetails.data!.subTotal}',
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
                        Text('SR ${cartDetails.data!.tax}',
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
                        Text('SR ${cartDetails.data!.deliveryFee}',
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
                        Text('SR ${cartDetails.data!.total}',
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
                      title: 'الدفع',
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => DeliveryAddressesScreen()))
                            .then(
                              (value) =>
                                  BlocProvider.of<CartCubit>(context).emit(
                                CartLoaded(cartDetails: cartDetails),
                              ),
                            );
                      }),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                ],
              ),
            );
          } else if (state is CartLoading) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0,
              content: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/loading.gif',
                    height: 0.4.sw,
                    width: 0.4.sw,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'السلة فارغة',
                style: TextStyle(fontSize: 24.sp),
              ),
            );
          }
        },
      ),
    );
  }
}
