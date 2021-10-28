import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';

import '../../constants.dart';

class AddVisaScreen extends StatefulWidget {
  @override
  State<AddVisaScreen> createState() => _AddVisaScreenState();
}

class _AddVisaScreenState extends State<AddVisaScreen> {
  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useBackgroundImage = false;

  OutlineInputBorder? border;

  bool notificationsBool = false;

  GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          child: Container(
            height: 1.sh,
            child: Column(
              children: [
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  height: 0.3.sh,
                  width: 1.1.sw,
                  isSwipeGestureEnabled: true,
                  cardHolderName: cardHolderName,
                  cardBgColor: Colors.black,
                  cvvCode: cvvCode,
                  showBackView: !notificationsBool,
                  onCreditCardWidgetChange: (creditCardBrand) {},
                ),
                CreditCardForm(
                  formKey: _formKey!, // Required
                  onCreditCardModelChange:
                      (CreditCardModel data) {}, // Required
                  themeColor: Color(Constants.mainColor),
                  obscureCvv: true,
                  obscureNumber: true,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم البطاقة',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'تاريخ الانتهاء',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'اسم حامل البطاقة',
                  ),
                  expiryDate: expiryDate, cardHolderName: cardHolderName,
                  cardNumber: cardNumber, cvvCode: cvvCode,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('اقلب البطاقة'),
                    SizedBox(
                      width: 10,
                    ),
                    FlutterSwitch(
                      width: 55,
                      height: 32,
                      toggleSize: 28.0,
                      value: notificationsBool,
                      borderRadius: 30.0,
                      padding: 0,
                      inactiveToggleColor: Color(Constants.mainColor),
                      activeToggleColor: Color(0xff748A9D),
                      activeSwitchBorder: Border.all(
                        color: Color(0xFF00D2B8),
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: Color(Constants.mainColor),
                      ),
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveIcon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      activeIcon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onToggle: (val) {
                        setState(() {
                          notificationsBool = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
