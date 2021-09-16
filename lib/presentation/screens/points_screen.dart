import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:toot/presentation/widgets/indigo_elevated_button.dart';

import '../../constants.dart';

class PointsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'نقاطي',
        isBack: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: 0.04.sh,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                height: 0.304.sh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(Constants.mainColor))),
                child: Column(
                  children: [
                    BuildPointsDetailsRow(
                      title: 'مجموع النقاط المكتسبة:',
                      number: '55',
                    ),
                    BuildPointsDetailsRow(
                      title: 'مجموع النقاط المستخدمة:',
                      number: '0',
                    ),
                    BuildPointsDetailsRow(
                      title: 'النقاط المتبقية :',
                      number: '55',
                    ),
                    BuildElevatedButton(
                      title: 'استخدام نقاطي',
                      function: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BuildItemDetailsCard(),
              BuildItemDetailsCard(),
              BuildItemDetailsCard(),
              BuildItemDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildItemDetailsCard extends StatelessWidget {
  const BuildItemDetailsCard({
    Key? key,
  }) : super(key: key);

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
                    'رقم الطلب    140',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'نقاط الطلب    22',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'النقاط المستخدمة     0',
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
                '11 نقطة',
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
