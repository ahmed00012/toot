import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:toot/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:toot/data/models/item.dart';
import 'package:toot/data/web_services/product_web_service.dart';
import 'package:toot/presentation/screens/single_item_screen.dart';
import 'package:toot/presentation/widgets/blurry_dialog.dart';

import '../../constants.dart';
import 'auth_screen.dart';

class ItemsScreen extends StatefulWidget {
  final List categories;
  final int shopId;
  final int catId;
  final int index;

  ItemsScreen(
      {required this.categories,
      required this.shopId,
      required this.catId,
      required this.index});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  static const _pageSize = 5;
  late int id;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey, int catId) async {
    try {
      final rawData = await ProductWebServices()
          .fetchItems(shopId: widget.shopId, catId: catId, page: pageKey);
      List newItems = rawData.map((item) => Item.fromJson(item)).toList();
      print(newItems.length);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    tabController = TabController(
      vsync: this,
      length: widget.categories.length,
      initialIndex: widget.index,
    );

    id = widget.catId;

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, id);
    });
    print(widget.shopId);
    super.initState();
  }

  // @override
  // void dispose() {
  //   _pagingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: Color(Constants.mainColor),
            ),
            splashRadius: 25,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'المنتجات',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Color(Constants.mainColor),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          // toolbarHeight: 0.18.sh,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          width: 1.sw,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                width: 1.sw,
                child: Center(
                  child: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: widget.categories.map((e) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _pagingController.itemList!.clear();
                          id = e.id;
                          _fetchPage(_pagingController.firstPageKey, e.id);
                          tabController.animateTo(widget.categories.indexOf(e));
                          setState(() {});
                        },
                        child: Tab(
                          child: Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(Constants.mainColor),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    indicator: RectangularIndicator(
                      color: Colors.grey.shade100,
                      horizontalPadding: 3,
                      verticalPadding: 3,
                      bottomRightRadius: 25,
                      bottomLeftRadius: 25,
                      topLeftRadius: 25,
                      topRightRadius: 25,
                      paintingStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PagedGridView<int, dynamic>(
                  // showNewPageProgressIndicatorAsGridChild: false,
                  // showNewPageErrorIndicatorAsGridChild: false,
                  showNoMoreItemsIndicatorAsGridChild: false,
                  pagingController: _pagingController,
                  padding: EdgeInsets.symmetric(
                      vertical: 0.02.sh, horizontal: 0.05.sw),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.52),
                  builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    noItemsFoundIndicatorBuilder: (_) => AlertDialog(
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
                    ),
                    itemBuilder: (context, item, index) => BuildItem(
                      title: item.name,
                      image: item.image,
                      isFav: item.inFavourite == 1 ? true : false,
                      itemId: item.id,
                      price: item.price,
                      shopId: widget.shopId,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class BuildItem extends StatelessWidget {
  final String title;
  final String? image;
  final String price;
  final bool isFav;
  final int itemId;
  final int shopId;

  BuildItem({
    required this.price,
    this.image,
    required this.title,
    required this.isFav,
    required this.itemId,
    required this.shopId,
  });

  _showDialog(BuildContext context, String title) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AuthScreen())),
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog('التسجيل اولا', title, continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool favStatus = isFav;
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SingleItemScreen(
                id: itemId,
                title: title,
                price: double.parse(price),
                shopId: shopId,
                isFav: favStatus,
              ),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 0.35.sh,
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  image!,
                                  fit: BoxFit.cover,
                                ))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 80,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'لا يتوفر صورة لهذا المنتج',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        height: 0.1.sw,
                        width: 0.1.sw,
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                          onPressed: () async {
                            if (await FlutterSecureStorage()
                                    .read(key: 'token') ==
                                null) {
                              _showDialog(context,
                                  'لا يمكن الاضافه الي المفضلة يجب عليك التسجيل اولا');
                            } else {
                              BlocProvider.of<FavoritesCubit>(context)
                                  .toggleFavoriteStatus(itemId: itemId)
                                  .then((value) => setState(() {
                                        favStatus = !favStatus;
                                      }));
                            }
                          },
                          icon: Icon(
                            favStatus
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                          splashRadius: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'RS $price',
                        style: TextStyle(
                            color: Color(Constants.mainColor), fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '3.50 RS',
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.sp,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 15.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
