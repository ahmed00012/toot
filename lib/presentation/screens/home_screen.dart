import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/product_cubit/product_cubit.dart';
import 'package:toot/presentation/screens/single_item_screen.dart';
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
  DateTime? currentBackPressTime;

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: "اضعط مرتين للخروج من التطبيق");
          return Future.value(false);
        } else
          exit(0);
      },
      child: Scaffold(
          appBar: BuildAppBar(
            title: 'المتجر',
          ),
          body: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
            if (state is CategoriesLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => SingleItemScreen(
                                      id: state.items![current].id!,
                                      title: state.items![current].name,
                                      price: double.parse(
                                          state.items![current].price!),
                                      shopId: state.items![current].vendorID,
                                      // isFav: state.items[current].inFavourite == 1
                                      //     ? true
                                      //     : false,
                                      fromPanner: true,
                                    )))
                            .then((value) =>
                                BlocProvider.of<ProductCubit>(context).emit(
                                    CategoriesLoaded(
                                        categories: state.items!)));
                      },
                      child: Center(
                        child: CarouselSlider.builder(
                          itemCount: state.items!.length,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    state.items![index].imageOne!,
                                    fit: BoxFit.contain,
                                    width: 0.8.sw,
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                    ShopsListView(
                      categories: state.categories,
                      function: () {
                        BlocProvider.of<ProductCubit>(context).emit(
                            CategoriesLoaded(
                                categories: state.categories,
                                items: state.items));
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                  child: Container(
                height: 120,
                width: 120,
                child: Lottie.asset('assets/images/lf20_j1klguuo.json'),
              ));
              // return AlertDialog(
              //   backgroundColor: Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   elevation: 0,
              //   content: Center(
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(15),
              //       child: Image.asset(
              //         'assets/images/loading.gif',
              //         height: 0.4.sw,
              //         width: 0.4.sw,
              //       ),
              //     ),
              //   ),
              // );
            }
          })),
    );
  }
}

class ShopsListView extends StatelessWidget {
  ShopsListView({required this.categories, required this.function});

  final List<dynamic> categories;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 0.28.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Text(
                    categories[index].categoryName ?? '',
                    style: TextStyle(
                        color: Color(Constants.mainColor),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: categories[index].markets!.length,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, imagesIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (_) => CategoriesScreen(
                                    shopId: categories[index]
                                        .markets![imagesIndex]
                                        .id,
                                    shopName: categories[index]
                                        .markets![imagesIndex]
                                        .name),
                              ),
                            )
                                .then((value) {
                              return function();
                            });
                          },
                          child: Container(
                            width: 0.8.sw,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: categories[index]
                                            .markets![imagesIndex]
                                            .image !=
                                        null
                                    ? CachedNetworkImage(
                                        imageUrl: categories[index]
                                            .markets![imagesIndex]
                                            .image!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.bottomRight,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 0.04.sh,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Colors.black45,
                                                  Colors.black12
                                                ],
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                              child: Text(
                                                categories[index]
                                                    .markets![imagesIndex]
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/images/image loading.gif',
                                          fit: BoxFit.cover,
                                          width: 0.6.sw,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/eCommerce-Shop.png',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/eCommerce-Shop.png',
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}
