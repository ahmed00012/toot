import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';

import '../../constants.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: 'المفضلة',
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.05.sw),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => FavoriteItem(
            name: 'Broccoli',
            image: 'assets/images/broccoli.png',
            price: '9.00',
          ),
          itemCount: 4,
        ));
  }
}

class FavoriteItem extends StatefulWidget {
  final String name;
  final String price;
  final String image;

  FavoriteItem({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  _FavoriteItemState createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 0.18.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.image,
                fit: BoxFit.fill,
                height: 0.2.sw,
                width: 0.2.sw,
              ),
            ),
            SizedBox(
              width: 0.08.sw,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 16.sp, color: Color(Constants.mainColor)),
                  ),
                ),
                Text(
                  '${widget.price}  SAR',
                  style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  width: 0.35.sw,
                  height: 0.042.sh,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color:Color(Constants.mainColor),
                        size: 18,
                      ),
                      label: Text(
                        'اضافة الي السله',
                        style: TextStyle(fontSize: 14.sp),
                      )),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.trashAlt,
                color: Color(0xffFD8C44),
                size: 22,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 0.04.sw,
            ),
          ],
        ),
      ),
    );
  }
}
