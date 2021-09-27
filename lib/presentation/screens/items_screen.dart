import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:toot/presentation/screens/single_item_screen.dart';

import '../../constants.dart';

class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Color(Constants.mainColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'المنتجات',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(Constants.mainColor),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        // toolbarHeight: 0.18.sh,
        backgroundColor: Colors.white,
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
      ),
      body: Container(
        width: 1.sw,
        height: 0.9.sh,
        child: DefaultTabController(
          length: 3,
          // initialIndex: 1,
          child: Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "البان",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(Constants.mainColor),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "خضراوات",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(Constants.mainColor),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "لحوم",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(Constants.mainColor),
                          ),
                        ),
                      ),
                    ],

                    // add it here
                    indicator: RectangularIndicator(
                      color: Colors.grey.shade100,
                      bottomRightRadius: 25,
                      bottomLeftRadius: 25,
                      topLeftRadius: 25,
                      topRightRadius: 25,
                      paintingStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
                GridView.builder(
                    itemCount: 4,
                    padding: EdgeInsets.only(
                        top: 0.04.sh, right: 0.05.sw, left: 0.05.sw),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.65),
                    itemBuilder: (context, index) => BuildItem()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isFav = false;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SingleItemScreen()));
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                            icon: Icon(
                              isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/strawberry.png',
                        width: 0.3.sw,
                        height: 0.2.sh,
                        fit: BoxFit.contain,
                      )),
                  Row(
                    children: [
                      Text(
                        '2.50 RS',
                        style: TextStyle(
                            color: Color(Constants.mainColor), fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '3.50 RS',
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.sp,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'فلفل الوان مستورد ممتاز',
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Fluttertoast.showToast(
//     msg: "تمت اضافة 3 منتجات الى سلتك",
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 3,
//     backgroundColor: Colors.green,
//     textColor: Colors.white,
//     fontSize: 16.0);
