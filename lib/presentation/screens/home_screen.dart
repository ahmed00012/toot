import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/product_cubit/product_cubit.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/data/models/category.dart';
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

  int current = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).fetchCategories(
        lat: LocalStorage.getData(key: 'lat'),
        long: LocalStorage.getData(key: 'long'));
    return Scaffold(
      appBar: BuildAppBar(
        title: 'المتجر',
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is ProductsLoaded) {
          return SingleChildScrollView(
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
                BuildShopsListView(
                  categories: state.categories,
                ),
              ],
            ),
          );
        } else {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
        }
      }),
    );
  }
}

class BuildShopsListView extends StatelessWidget {
  BuildShopsListView({required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        height: 0.18.sh,
        child: ListView.builder(
            itemCount: categories.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              print(categories[index].categoryName);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      categories[index].categoryName,
                      style: TextStyle(
                          color: Color(Constants.mainColor),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, imagesIndex) {
                        print(categories[index].markets[imagesIndex].image);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CategoriesScreen()));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  categories[index].markets[imagesIndex].image,
                                  fit: BoxFit.fill,
                                  width: 0.6.sw,
                                )),
                          ),
                        );
                      }),
                ],
              );
            }),
      ),
    );
  }
}
