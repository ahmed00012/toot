import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/presentation/screens/auth_screen.dart';
import 'package:toot/presentation/screens/chat_screen.dart';
import 'package:toot/presentation/screens/orders_screen.dart';
import 'package:toot/presentation/screens/points_screen.dart';
import 'package:toot/presentation/screens/profile_screen.dart';
import 'package:toot/presentation/widgets/blurry_dialog.dart';
import 'package:toot/presentation/widgets/customised_appbar.dart';

class SettingsScreen extends StatelessWidget {
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
                  if (LocalStorage.getData(key: 'token') == '') {
                    _showDialog(
                        context, 'لا يمكن عرض المفضلة يجب عليك التسجيل اولا');
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => OrdersScreen()));
                  }
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
                function: () {
                  print(LocalStorage.getData(key: 'token'));
                  if (LocalStorage.getData(key: 'token') == '') {
                    _showDialog(
                        context, 'لا يمكن عرض المفضلة يجب عليك التسجيل اولا');
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PointsScreen()));
                  }
                },
              ),
              SettingsItem(
                title: 'اتصل بنا',
                image: 'assets/images/Group 1302.png',
              ),
              LocalStorage.getData(key: 'isLogin') != null &&
                      LocalStorage.getData(key: 'isLogin')
                  ? SettingsItem(
                      title: 'تسجيل الخروج',
                      image: 'assets/images/icon-sign-out.png',
                      function: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => AuthScreen()),
                            (Route<dynamic> route) => false);
                        // LocalStorage.removeData(key: 'token');
                        // LocalStorage.removeData(key: 'cart_token');
                        LocalStorage.saveData(key: 'isLogin', value: false);
                        LocalStorage.saveData(key: 'token', value: '');
                        LocalStorage.saveData(key: 'cart_token', value: '');
                      },
                    )
                  : SettingsItem(
                      title: 'تسجيل الدخول',
                      image: 'assets/images/enter.png',
                      function: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => AuthScreen()),
                            (Route<dynamic> route) => false);
                      },
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
        height: 0.075.sh,
        margin: EdgeInsets.symmetric(vertical: 5),
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
