import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:toot/constants.dart';
import 'package:toot/data/models/offer.dart';
import 'package:toot/data/web_services/product_web_service.dart';
import 'package:toot/presentation/screens/single_notification_screen.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';

class NotificationScreen extends StatefulWidget {
  static const _pageSize = 5;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);
  late TabController tabController;

  Future<void> _fetchPage(context, int pageKey) async {
    try {
      final rawData = await ProductWebServices().fetchOffers(pageKey);
      List newItems = rawData.map((offer) => Offer.fromJson(offer)).toList();
      print(newItems.length);
      final isLastPage = newItems.length < NotificationScreen._pageSize;
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
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(context, pageKey);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: 'تنبيهات',
        ),
        body: PagedGridView<int, dynamic>(
          // showNewPageProgressIndicatorAsGridChild: false,
          // showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          pagingController: _pagingController,
          padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.05.sw),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 1.4),
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
              firstPageProgressIndicatorBuilder: (_) {
                return Container(
                  height: 0.8.sh,
                  child: Center(
                      child: Container(
                    height: 120,
                    width: 120,
                    child: Lottie.asset('assets/images/lf20_j1klguuo.json'),
                  )),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return Container(
                  height: 0.8.sh,
                  child: Center(
                      child: Text(
                    'لا يوجد تنبيهات حتي الان',
                    style: TextStyle(fontSize: 20),
                  )),
                );
              },
              itemBuilder: (context, item, index) => BuildNotificationItem(
                    title: item.title,
                    image: item.image,
                    details: item.description,
                    id: item.id,
                  )),
        ));
  }
}

class BuildNotificationItem extends StatelessWidget {
  final String title;
  final String details;
  final String image;
  final int id;

  BuildNotificationItem(
      {required this.title,
      required this.image,
      required this.details,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SingleNotificationScreen(
                  id: id,
                  details: details,
                  title: title,
                  image: image,
                )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 0.25.sh,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: image != ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      child: Image.network(
                        image,
                        width: 1.sw,
                        height: 0.4.sh,
                        fit: BoxFit.cover,
                      ))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported_outlined,
                          size: 150,
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
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.03.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Color(Constants.mainColor),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    details,
                    style: TextStyle(color: Colors.grey.shade500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
