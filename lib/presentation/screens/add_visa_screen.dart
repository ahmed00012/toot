import 'package:flutter/material.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/default_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class AddVisaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
              appBar: AppBar(
          title: Text(
            'اضافة فيزا',
            style: TextStyle(
                color: Color(Constants.mainColor), fontWeight: FontWeight.w300),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: Color(Constants.mainColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.06.sw, vertical: 0.03.sh),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BuildTextField(
                  icon: 'assets/images/add card  (2).png',
                  hint: 'اسم حامل البطاقة',
                ),
                BuildTextField(
                  icon: 'assets/images/add card  (3).png',
                  hint: 'رقم البطاقة',
                ),
                BuildTextField(
                  icon: 'assets/images/add card  (4).png',
                  hint: 'تاريخ الانتهاء',
                ),
                BuildTextField(
                  icon: 'assets/images/add card  (1).png',
                  hint: 'كود الحماية',
                ),
                SizedBox(
                  height: 0.25.sh,
                ),
                BuildIndigoButton(title: 'الاستمرار', function: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
