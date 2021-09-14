import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class SingleItemScreen extends StatefulWidget {
  const SingleItemScreen({Key? key}) : super(key: key);

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
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
        backgroundColor: Colors.grey.shade50,
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
                            fontSize: 26.sp,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.03.sh),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 0.45.sw,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF0F4F8),
                                contentPadding: EdgeInsets.only(
                                    left: 0.06.sw, right: 0.02.sw),
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
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff4A4B4D)),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 28,
                              color: Color(Constants.mainColor),
                            ),
                            iconSize: 24,
                            elevation: 4,
                            style: TextStyle(
                                color: Color(Constants.mainColor),
                                fontSize: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                kindDropdownValue = newValue;
                              });
                            },
                            items: kindsList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        width: 0.35.sw,
                        decoration: BoxDecoration(
                            color: Color(0xffF0F4F8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              splashRadius: 1,
                              icon: Icon(
                                Icons.add,
                                size: 20,
                                color: Color(Constants.mainColor),
                              ),
                              onPressed: () {
                                setState(() {
                                  number++;
                                });
                              },
                            ),
                            Text(
                              number.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            IconButton(
                              splashRadius: 1,
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                                color: Color(Constants.mainColor),
                              ),
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
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                width: 1.sw,
                height: 0.06.sh,
                child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color(Constants.mainColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    label: Text('اضافة الي السله')),
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
