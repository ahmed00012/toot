import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/cubits/product_cubit/product_cubit.dart';
import 'package:toot/presentation/screens/items_screen.dart';

import '../../constants.dart';

class CategoriesScreen extends StatefulWidget {
  final int shopId;
  CategoriesScreen({required this.shopId});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    getShopCat();
    super.initState();
  }

  getShopCat() {
    BlocProvider.of<ProductCubit>(context)
        .fetchShopCategories(shopId: widget.shopId);
  }

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
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ShopCategoriesLoaded) {
              final shopCat = state.shopCategories;
              return GridView.builder(
                itemCount: shopCat.length,
                padding: EdgeInsets.only(
                  top: 0.03.sh,
                  right: 0.05.sw,
                  left: 0.05.sw,
                ),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5,
                ),
                itemBuilder: (context, index) => CategoryItem(
                  image: shopCat[index].image,
                  title: shopCat[index].name,
                  shopId: widget.shopId,
                  categoryId: shopCat[index].id,
                  categories: shopCat,
                  function: getShopCat,
                  index: index,
                ),
              );
            } else {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
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
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;
  final int shopId;
  final int categoryId;
  final List categories;
  final int index;
  final Function function;

  CategoryItem(
      {required this.image,
      required this.title,
      required this.categories,
      required this.categoryId,
      required this.shopId,
      required this.function,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (_) => ItemsScreen(
                    categories: categories,
                    catId: categoryId,
                    shopId: shopId,
                    index: index)))
            .then((value) {
          return function();
        });
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
              child: Image.network(
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
