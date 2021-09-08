import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toot/presentation/screens/add_delivery_screen.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/delivery_app_bar.dart';
import 'package:toot/presentation/widgets/single_choice_item.dart';

import 'delivery_options_screen.dart';

class DeliveryAddressesScreen extends StatefulWidget {
  @override
  _DeliveryAddressesScreenState createState() =>
      _DeliveryAddressesScreenState();
}

class _DeliveryAddressesScreenState extends State<DeliveryAddressesScreen> {
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
        title: 'عناوين التوصيل',
        isLocation: true,
      ),
      bottomSheet: Container(
        height: 0.2.sh,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AddDeliveryScreen()));
              },
              child: Container(
                height: 0.065.sh,
                width: 0.5.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('إضافة عنوان جديد'),
                  ],
                ),
              ),
            ),
            BuildIndigoButton(
                title: 'استمرار',
                function: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DeliveryOptionsScreen()));
                })
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 0.04.sw, left: 0.04.sw, top: 0.03.sw),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChoiceItem(
                function: singleSelection,
                choicesList: selections,
                index: 0,
                title: "الرياض , حي السلام",
              ),
              SingleChoiceItem(
                function: singleSelection,
                choicesList: selections,
                index: 1,
                title: "المدينة المنورة , العزيزة",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
