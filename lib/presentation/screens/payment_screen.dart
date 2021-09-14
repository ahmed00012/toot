import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/delivery_app_bar.dart';
import 'package:toot/presentation/widgets/single_choice_payment.dart';
import 'order_summary_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<bool> selections = List<bool>.filled(2, false, growable: false);

  List<bool> singleSelection(bool selection, int index) {
    if (selections.contains(true)) {
      int i = selections.indexOf(true);
      selections[i] = false;
      selections[index] = true;
    } else {
      selections[index] = selection;
    }
    setState(() {});
    print(selections);
    return selections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildDeliveryBar(
        title: 'طريقة الدفع',
        isPayment: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleChoicePayment(
                function: singleSelection,
                choicesList: selections,
                index: 0,
                title: "الدفع عن طريق الفيزا",
                icon: Icons.payment,
                isVisa: true,
              ),
              SingleChoicePayment(
                function: singleSelection,
                choicesList: selections,
                index: 1,
                title: "الدفع عند الاستلام",
                icon: Icons.attach_money,
                isVisa: false,
              ),
            ],
          ),
          SizedBox(
            height: 0.45.sh,
          ),
          BuildIndigoButton(
              title: 'الاستمرار',
              function: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => OrderSummaryScreen(),
                  ),
                );
              })
        ],
      ),
    );
  }
}
