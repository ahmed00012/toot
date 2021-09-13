import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/screens/items_screen.dart';
import '../../constants.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {'image': 'assets/images/kale.png', 'title': 'Skimmed milk'},
    {'image': 'assets/images/strawberry-shadow.png', 'title': 'Strawberry'},
    {'image': 'assets/images/pepper-shadow.png', 'title': 'Legumes'},
    {'image': 'assets/images/broccoli-shadow.png', 'title': 'Vegetables'}
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                      color: Color(Constants.mainColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Center(
                    child: Text(
                      'الاقسام',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(Constants.mainColor),
                      ),
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
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(Constants.mainColor),
                    size: 25,
                  ),
                  hintText: 'بحث سريع',
                  hintStyle: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 18.sp),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 0.18.sh,
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
        ),
        body: GridView.builder(
          itemCount: items.length,
          padding: EdgeInsets.only(top: 0.03.sh, right: 0.05.sw, left: 0.05.sw),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2 / 2.5),
          itemBuilder: (context, index) => CategoryItem(
              image: items[index]['image']!, title: items[index]['title']!),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;
  CategoryItem({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ItemsScreen()));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 0.3.sh,
        width: 0.3,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                height: 0.2.sh,
                width: 0.3.sw,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Color(
                    Constants.mainColor,
                  ),
                  fontSize: 18.sp),
            )
          ],
        ),
      ),
    );
  }
}
