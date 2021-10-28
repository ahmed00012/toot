import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';

import '../../constants.dart';

class PointsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).fetchMyPoints();
    return Scaffold(
      appBar: BuildAppBar(
        title: 'نقاطي',
        isBack: false,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is MyPointsLoaded) {
            final points = state.points;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      height: 0.304.sh,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Color(Constants.mainColor))),
                      child: Column(
                        children: [
                          BuildPointsDetailsRow(
                            title: 'مجموع النقاط المكتسبة:',
                            number: points.totalPoints.toString(),
                          ),
                          BuildPointsDetailsRow(
                            title: 'الحد الادني لتحويل النقاط :',
                            number: points.pointsLimit.toString(),
                          ),
                          BuildPointsDetailsRow(
                            title: 'النقاط المتبقية :',
                            number: points.balance.toString(),
                          ),
                          SizedBox(
                            width: 0.41.sw,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: points.totalPoints! >
                                      points.pointsLimit!
                                  ? () {
                                      BlocProvider.of<CartCubit>(context)
                                          .covertPoints()
                                          .then((value) => Fluttertoast.showToast(
                                              msg:
                                                  "اضعط مرتين للخروج من التطبيق"));
                                    }
                                  : null,
                              child: Text(
                                'استخدام نقاطي',
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(Constants.mainColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      itemCount: points.points!.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) => BuildItemDetailsCard(
                        converted: points.points![index].converted!,
                        orderId: points.points![index].orderId!,
                        points: points.points![index].points!,
                      ),
                    )
                  ],
                ),
              ),
            );
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

class BuildItemDetailsCard extends StatelessWidget {
  final int orderId;
  final int points;
  final int converted;
  BuildItemDetailsCard(
      {required this.points, required this.converted, required this.orderId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        height: 0.18.sh,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' رقم الطلب   $orderId',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    ' نقاط الطلب$points',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    converted == 0 ? 'النقاط غير مستخدمة' : 'النقاط استخدمت',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            Container(
              height: 0.2.sw,
              width: 0.2.sw,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(Constants.mainColor)),
              child: Center(
                  child: Text(
                '$pointsنقطة ',
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class BuildPointsDetailsRow extends StatelessWidget {
  final String title;
  final String number;

  BuildPointsDetailsRow({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 22.sp,
                color: Color(Constants.mainColor),
                fontWeight: FontWeight.w800),
          ),
          Text(
            number,
            style: TextStyle(
                fontSize: 22.sp,
                color: Color(Constants.mainColor),
                fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
