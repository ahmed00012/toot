import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:toot/presentation/screens/cart_screen.dart';
import 'package:toot/presentation/screens/favorites_screen.dart';
import 'package:toot/presentation/screens/home_screen.dart';
import 'package:toot/presentation/screens/notifications_screen.dart';
import 'package:toot/presentation/screens/settings_screen.dart';
import '../../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? animation;
  late CurvedAnimation curve;
  PageController _pageController = PageController();
  int currentTab = 0;
  bool isSupportedCheck = false;

  final iconList = [
    'assets/images/cdf.png',
    'assets/images/Group.png',
    'assets/images/icon-store.png',
    'assets/images/icon-cart.png',
    'assets/images/icon-settings.png',
  ];

  List<Widget> _screens = [
    FavoritesScreen(),
    NotificationScreen(),
    HomeScreen(),
    CartScreen(),
    SettingsScreen()
  ];

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.amber : Colors.white;
          if (index == 2) {
            return FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  height: 0.16.sw,
                  width: 0.16.sw,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Image.asset(
                    iconList[index],
                    scale: 0.7,
                  ),
                ),
              ),
            );
          }
          return Image.asset(
            iconList[index],
            color: color,
            scale: 0.9,
          );
        },
        backgroundColor: Color(Constants.mainColor),
        activeIndex: currentTab,
        gapLocation: GapLocation.none,
        splashColor: Colors.green.shade700,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        height: MediaQuery.of(context).size.height * 0.12,
        onTap: (index) => setState(() => this._onItemTapped(index)),
      ),
    );
  }
}
