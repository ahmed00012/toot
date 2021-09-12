import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class SingleItemScreen extends StatefulWidget {
  const SingleItemScreen({Key? key}) : super(key: key);

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  bool isAdded = false;
  bool isFav = false;
  int number = 1;
  String? kindDropdownValue;
  List<String> kindsList = ['استرالي      SR 0.85', 'العربي        SR 0.80'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'blueberry',
          style: TextStyle(
              color: Color(Constants.mainColor), fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Color(Constants.mainColor), size: 25),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border_outlined,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset('assets/images/broccoli.png'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "9.45"
                        " RS ",
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4A4B4D)),
                      ),
                      Text(' لكل كيلو  /',
                          style: TextStyle(
                            color: Color(0xff4A4B4D),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF0F4F8),
                      contentPadding:
                          EdgeInsets.only(left: 0.06.sw, right: 0.02.sw),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none)),
                  validator: (value) =>
                      value == null ? 'Please select Language' : null,
                  isExpanded: true,
                  value: kindDropdownValue,
                  hint: Text(
                    'اختار النوع',
                    style: TextStyle(fontSize: 17, color: Color(0xff4A4B4D)),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: Colors.grey.shade500,
                  ),
                  iconSize: 24,
                  elevation: 4,
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      kindDropdownValue = newValue;
                    });
                  },
                  items:
                      kindsList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.04.sh),
                child: GestureDetector(
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
                    height: 0.09.sh,
                    decoration: BoxDecoration(
                        color: !isAdded
                            ? Color(Constants.mainColor)
                            : Color(0xffF0F4F8),
                        borderRadius: BorderRadius.circular(30)),
                    child: !isAdded
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/addToCart.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'اضافة الي السلة',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.sp),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'الوصف',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 24.sp),
                ),
              ),
              Text(
                'يعد البروكلي (Broccoli) من الأطعمة الخارقة لاحتوائه على كمية عالية من العناصر الأساسية والفيتامينات وعدد قليل من السعرات الحرارية، ما جعله من الأطعمة المرغوبة عند كثير من الأشخاص حول العالم',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16.sp),
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'التخزين',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 24.sp),
                ),
              ),
              Text(
                'للحفاظ عليها طازجه ,حافظ عليها مجمده',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16.sp),
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'المنشأ',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 24.sp),
                ),
              ),
              Text(
                'منتج من المملكه المتحده,اليابانوايرلندا ونيوزلاند',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16.sp),
              ),
              SizedBox(
                height: 0.05.sh,
              )
            ],
          ),
        ),
      ),
    );
  }
}
