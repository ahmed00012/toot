import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool? isSearch;
  final bool? isLeading;
  BuildAppBar(
      {required this.title, this.isSearch = true, this.isLeading = true});

  @override
  Size get preferredSize => Size.fromHeight(0.13.sh);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
      leading: isLeading!
          ? Visibility(
              visible: isSearch!,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 25,
                ),
                onPressed: () {},
              ),
            )
          : IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      toolbarHeight: 0.15.sh,
      backgroundColor: Color(Constants.mainColor),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
    );
  }
}
