import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Center(
                  child: Text(
                    'المنتجات',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 0.1.sw,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 0.1.sh,
              width: 0.8.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'البان',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    'فواكه',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      'خضروات',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(Constants.mainColor),
                          fontSize: 16.sp),
                    ),
                  ),
                  Text(
                    'لحوم',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 0.18.sh,
        backgroundColor: Color(Constants.mainColor),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
      ),
      body: GridView.builder(
          itemCount: 4,
          padding: EdgeInsets.only(top: 0.04.sh, right: 0.05.sw, left: 0.05.sw),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2 / 3),
          itemBuilder: (context, index) => BuildItem()),
    );
  }
}

class BuildItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isAdded = false;
    int number = 1;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SingleItemScreen()));
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/strawberry.png',
                      width: 0.3.sw,
                      height: 0.2.sh,
                      fit: BoxFit.cover,
                    )),
                Row(
                  children: [
                    Text(
                      '2.50 RS',
                      style: TextStyle(color: Colors.red, fontSize: 18.sp),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '3.50 RS',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'فلفل الوان مستورد ممتاز',
                    style:
                        TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAdded = true;
                    });
                    Fluttertoast.showToast(
                        msg: "تمت اضافة 3 منتجات الى سلتك",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Container(
                    height: 0.06.sh,
                    decoration: BoxDecoration(
                        color: !isAdded
                            ? Color(Constants.mainColor)
                            : Color(0xffF0F4F8),
                        borderRadius: BorderRadius.circular(10)),
                    child: !isAdded
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/addToCart.png'),
                              Text(
                                'سلة للشراء',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                splashRadius: 1,
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    number++;
                                  });
                                },
                              ),
                              Text(
                                number.toString(),
                                style: TextStyle(
                                    color: Color(0xffBB9265), fontSize: 22),
                              ),
                              IconButton(
                                splashRadius: 1,
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (number == 1) {
                                    return;
                                  } else {
                                    setState(() {
                                      number--;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
