import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/default_text_field.dart';

import '../../constants.dart';

class ActivateAccountScreen extends StatelessWidget {
  const ActivateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.16.sh,
              ),
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                    color: Color(Constants.mainColor), fontSize: 26.sp),
              ),
              SizedBox(
                height: 0.04.sh,
              ),
              FaIcon(
                FontAwesomeIcons.sms,
                color: Color(Constants.mainColor),
                size: 100,
              ),
              SizedBox(
                height: 0.03.sh,
              ),
              BuildTextField(
                icon: 'assets/images/smartphone.png',
                hint: 'كود الرسالة',
              ),
              SizedBox(
                height: 0.22.sh,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.04.sh),
                child: BuildIndigoButton(
                  title: 'دخول',
                  function: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => BottomNavBar()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
