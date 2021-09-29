import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:toot/data/models/item.dart';
import 'package:toot/data/web_services/product_web_service.dart';
import 'package:toot/presentation/screens/single_item_screen.dart';

import '../../constants.dart';

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

  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey, int catId) async {
    try {
      final rawData = await ProductWebServices()
          .fetchItems(shopId: widget.shopId, catId: catId, page: pageKey);
      List newItems = rawData.map((item) => Item.fromJson(item)).toList();
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

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, widget.catId);
    });

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
                  tabs: widget.categories
                      .map(
                        (e) => Tab(
                          child: InkWell(
                            onTap: () {
                              tabController
                                  .animateTo(widget.categories.indexOf(e));
                              _fetchPage(1, e.id);
                            },
                            child: Text(
                              e.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(Constants.mainColor),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
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
                    crossAxisCount: 2, childAspectRatio: 0.62),
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, item, index) => BuildItem(
                    title: item.name,
                    image: item.image,
                    isFav: item.inFavourite,
                    itemId: item.id,
                    price: item.price,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final int isFav;
  final int itemId;
  BuildItem(
      {required this.price,
      required this.image,
      required this.title,
      required this.isFav,
      required this.itemId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SingleItemScreen()));
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          //   isFav = !isFav;
                          // });
                        },
                        icon: Icon(
                          isFav == 1
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: Colors.red,
                        ),
                        splashRadius: 1,
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 0.3.sw,
                      height: 0.22.sh,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            image,
                            fit: BoxFit.fill,
                          )),
                    ),
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
                          color: Colors.grey.shade400, fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Fluttertoast.showToast(
//     msg: "تمت اضافة 3 منتجات الى سلتك",
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 3,
//     backgroundColor: Colors.green,
//     textColor: Colors.white,
//     fontSize: 16.0);
