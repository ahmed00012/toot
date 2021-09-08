import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class BuildDeliveryBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool? isLocation;
  final bool? isDelivery;
  final bool? isPayment;
  final bool? isSummary;

  BuildDeliveryBar({
    required this.title,
    this.isDelivery = false,
    this.isLocation = false,
    this.isPayment = false,
    this.isSummary = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(0.18.sh);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_outlined),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Color(Constants.mainColor),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
      bottom: PreferredSize(
          child: Container(
            height: 0.1.sh,
            decoration: BoxDecoration(
              color: Color(Constants.mainColor),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.ltr,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isSummary! ? Colors.white : Colors.transparent),
                  child: Icon(
                    FontAwesomeIcons.list,
                    color:
                        isSummary! ? Color(Constants.mainColor) : Colors.white,
                    size: 20,
                  ),
                ),
                Icon(
                  Icons.forward,
                  size: 15,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isPayment! ? Colors.white : Colors.transparent),
                  child: Icon(
                    FontAwesomeIcons.creditCard,
                    color:
                        isPayment! ? Color(Constants.mainColor) : Colors.white,
                    size: 20,
                  ),
                ),
                Icon(
                  Icons.forward,
                  size: 15,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isDelivery! ? Colors.white : Colors.transparent),
                  child: Icon(
                    FontAwesomeIcons.truck,
                    color:
                        isDelivery! ? Color(Constants.mainColor) : Colors.white,
                    size: 20,
                  ),
                ),
                Icon(
                  Icons.forward,
                  size: 15,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isLocation! ? Colors.white : Colors.transparent),
                  child: Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color:
                        isLocation! ? Color(Constants.mainColor) : Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(0.1.sh)),
    );
  }
}
