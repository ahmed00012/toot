import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/constants.dart';
import 'package:toot/presentation/screens/registration_screen.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/text_button.dart';
import 'package:toot/presentation/widgets/default_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, -2), // changes position of shadow
                    ),
                  ],
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                height: 0.875.sh,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.h),
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            color: Color(Constants.mainColor), fontSize: 26.sp),
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
                      style:
                          TextStyle(color: Color(0xffA6BCD0), fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    BuildIndigoButton(
                      title: 'دخول',
                      function: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => BottomNavBar()));
                      },
                    )
                  ],
                ),
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
    );
  }
}
