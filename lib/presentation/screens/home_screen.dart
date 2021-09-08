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
  final List<String> imagesList1 = [
    'assets/images/s.png',
    'assets/images/zdf.png',
  ];

  final List<String> imagesList2 = [
    'assets/images/card-tropical.png',
    'assets/images/card-berries.png',
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
                padding: EdgeInsets.symmetric(vertical: 25.w),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/main_pic.png',
                      fit: BoxFit.contain,
                      width: 0.95.sw,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
              child: Text(
                'محلات الخضراوات',
                style: TextStyle(
                    color: Color(Constants.mainColor),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w300),
              ),
            ),
            BuildShopsListView(imagesList: imagesList1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
              child: Text(
                'محلات اللحوم',
                style: TextStyle(
                    color: Color(Constants.mainColor),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w300),
              ),
            ),
            BuildShopsListView(imagesList: imagesList2),
          ],
        ),
      ),
    );
  }
}

class BuildShopsListView extends StatelessWidget {
  const BuildShopsListView({
    Key? key,
    required this.imagesList,
  }) : super(key: key);

  final List<String> imagesList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.sh,
      child: ListView.builder(
          itemCount: imagesList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CategoriesScreen()));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      imagesList[0],
                      fit: BoxFit.cover,
                      width: 0.8.sw,
                      height: 0.32.sh,
                    )),
              )),
    );
  }
}
