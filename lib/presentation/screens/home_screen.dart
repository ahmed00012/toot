import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:toot/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imagesBannerList = [
    'assets/images/main_pic.png',
    'assets/images/main_pic.png',
    'assets/images/main_pic.png',
  ];

  final List<String> imagesList1 = [
    'assets/images/fruits ss.jpg',
    'assets/images/fruits ss.jpg',
    'assets/images/fruits ss.jpg',
  ];

  final List<String> imagesList2 = [
    'assets/images/meat.png',
    'assets/images/meat.png',
    'assets/images/meat.png',
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'المتجر',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: CarouselSlider.builder(
                  itemCount: imagesBannerList.length,
                  options: CarouselOptions(
                      height: 0.25.sh,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      }),
                  itemBuilder: (ctx, index, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            imagesBannerList[index],
                            fit: BoxFit.contain,
                            width: 0.8.sw,
                          )),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.sw, vertical: 10),
              child: Text(
                'محلات الفاكهة',
                style: TextStyle(
                    color: Color(Constants.mainColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300),
              ),
            ),
            BuildShopsListView(
              imagesList: imagesList1,
              width: 0.6.sw,
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.sw, vertical: 10),
              child: Text(
                'محلات اللحوم',
                style: TextStyle(
                    color: Color(Constants.mainColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300),
              ),
            ),
            BuildShopsListView(
              imagesList: imagesList2,
              width: 0.6.sw,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildShopsListView extends StatelessWidget {
  const BuildShopsListView(
      {Key? key, required this.imagesList, required this.width})
      : super(key: key);

  final double width;

  final List<String> imagesList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.18.sh,
      child: ListView.builder(
          itemCount: imagesList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CategoriesScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        imagesList[0],
                        fit: BoxFit.fill,
                        width: width,
                      )),
                ),
              )),
    );
  }
}
