import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/product_cubit/product_cubit.dart';
import 'package:toot/data/local_storage.dart';
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
  void initState() {
    BlocProvider.of<ProductCubit>(context).fetchCategories(
        lat: LocalStorage.getData(key: 'lat'),
        long: LocalStorage.getData(key: 'long'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'المتجر',
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is CategoriesLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
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
                BuildShopsListView(
                  categories: state.categories,
                  function: () {
                    BlocProvider.of<ProductCubit>(context)
                        .emit(CategoriesLoaded(categories: state.categories));
                  },
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
  BuildShopsListView({required this.categories, required this.function});

  final List<dynamic> categories;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                  child: Text(
                    categories[index].categoryName ?? '',
                    style: TextStyle(
                        color: Color(Constants.mainColor),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: categories[index].markets!.length,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                                        .id),
                              ),
                            )
                                .then((value) {
                              return function();
                            });
                          },
                          child: Container(
                            width: 0.6.sw,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
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
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/images/image loading.gif',
                                          fit: BoxFit.fill,
                                          width: 0.6.sw,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/eCommerce-Shop.png',
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/eCommerce-Shop.png',
                                        fit: BoxFit.fill,
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
