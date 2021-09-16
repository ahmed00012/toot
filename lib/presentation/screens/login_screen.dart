import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/screens/registration_screen.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/default_text_field.dart';
import 'package:toot/presentation/widgets/text_button.dart';

import 'onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تسجيل الدخول',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
          ),
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.05.sh),
                    child: Image.asset(
                      "assets/images/Group 1547.png",
                      fit: BoxFit.contain,
                      height: 0.20.sh,
                      width: 0.40.sw,
                    ),
                  ),
                ),
                BuildTextField(
                  icon: 'assets/images/smartphone.png',
                  hint: 'رقم الجوال',
                ),
                BuildTextField(
                  icon: 'assets/images/icon-padlock.png',
                  hint: 'كلمة المرور',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'هل نسيت كلمة السر ؟',
                  style: TextStyle(color: Color(0xffA6BCD0), fontSize: 18.sp),
                ),
                SizedBox(
                  height: 100.h,
                ),
                BuildIndigoButton(
                  title: 'دخول',
                  function: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => OnboardingScreen()));
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => BottomNavBar()));
                  },
                ),
                BuildTextButton(
                  title: 'انشاء حساب',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => RegistrationScreen()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
