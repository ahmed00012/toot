import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/presentation/screens/auth_screen.dart';
import 'package:toot/presentation/screens/cart_screen.dart';
import 'package:toot/presentation/screens/favorites_screen.dart';
import 'package:toot/presentation/screens/home_screen.dart';
import 'package:toot/presentation/screens/notifications_screen.dart';
import 'package:toot/presentation/screens/settings_screen.dart';

import '../../constants.dart';
import 'blurry_dialog.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? animation;
  late CurvedAnimation curve;
  PageController _pageController = PageController(initialPage: 0);
  int currentTab = 0;
  final autoSizeGroup = AutoSizeGroup();

  final List<IconData> iconList = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.solidBell,
    FontAwesomeIcons.userCog,
  ];

  final iconTitlesAR = <String>[
    'الرئيسية',
    'المفضلة',
    'التنبيهات',
    'الاعدادات',
  ];

  List<Widget> _screens = [
    HomeScreen(),
    FavoritesScreen(),
    NotificationScreen(),
    SettingsScreen()
  ];

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

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
      body: PageView(
        controller: _pageController,
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: animation!,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Color(Constants.mainColor),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Color(Constants.mainColor) : Colors.grey;
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    iconList[index],
                    color: color,
                    size: 20,
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AutoSizeText(
                      // Localizations.localeOf(context).languageCode == "ar"
                      //     ? iconTitlesAr[index]
                      iconTitlesAR[index],
                      maxLines: 1,
                      style: TextStyle(color: color, fontSize: 8),
                      group: autoSizeGroup,
                    ),
                  )
                ],
              ),
            );
          },
          backgroundColor: Colors.white,
          activeIndex: currentTab,
          splashColor: Color(Constants.mainColor),
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.center,
          height: MediaQuery.of(context).size.height * 0.1,
          // leftCornerRadius: 32,
          // rightCornerRadius: 32,
          onTap: (index) async {
            if (LocalStorage.getData(key: 'token') == null && index == 1) {
              _showDialog(context, 'لا يمكن عرض المفضلة يجب عليك التسجيل اولا');
            } else {
              setState(() {
                this._onItemTapped(index);
              });
            }
          }),
    );
  }
}
