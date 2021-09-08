import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: 'المفضلة',
          isSearch: false,
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.03.sw),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => FavoriteItem(
            name: 'Broccoli',
            image: 'assets/images/broccoli.png',
            price: '9.00',
          ),
          separatorBuilder: (context, index) => Divider(),
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
    return Container(
      height: 0.22.sh,
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
                  style: TextStyle(fontSize: 20.sp, color: Color(0xffB09B87)),
                ),
              ),
              Text(
                '${widget.price}  SAR',
                style: TextStyle(color: Color(0xff80392C), fontSize: 20.sp),
              ),
              SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'الاضافة الي السلة',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold),
                ),
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
    );
  }
}
