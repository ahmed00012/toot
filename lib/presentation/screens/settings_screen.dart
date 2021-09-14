import 'package:flutter/material.dart';
import 'package:toot/presentation/screens/chat_screen.dart';
import 'package:toot/presentation/screens/orders_screen.dart';
import 'package:toot/presentation/screens/profile_screen.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: 'الاعدادات',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SettingsItem(
                title: 'حسابي',
                image: 'assets/images/icon-account.png',
                function: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
              ),
              SettingsItem(
                title: 'طلباتي',
                image: 'assets/images/icon-cart.png',
                function: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => OrdersScreen()));
                },
              ),
              SettingsItem(
                title: 'نشر التطبيق',
                image: 'assets/images/icon-share.png',
              ),
              SettingsItem(
                title: 'انضم الينا',
                image: 'assets/images/icon-mail.png',
              ),
              SettingsItem(
                title: 'محادثات',
                image: 'assets/images/add card  (4).png',
                function: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ChatScreen()));
                },
              ),
              SettingsItem(
                title: 'نقاطي',
                image: 'assets/images/cdf.png',
              ),
              SettingsItem(
                title: 'اتصل بنا',
                image: 'assets/images/Group 1302.png',
              ),
              SettingsItem(
                title: 'تسجيل الخروج',
                image: 'assets/images/icon-sign-out.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String image;
  final Function? function;
  SettingsItem({required this.title, required this.image, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return function!();
      },
      child: Container(
        height: 0.09.sh,
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xffDBE2ED),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 0.05.sw,
              fit: BoxFit.cover,
              color: Colors.grey.shade700,
            ),
            SizedBox(
              width: 0.04.sw,
            ),
            Text(title),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
