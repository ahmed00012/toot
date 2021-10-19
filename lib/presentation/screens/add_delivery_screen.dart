import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/constants.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';

class AddDeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? address;
    String? district;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'اضافة عنوان',
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
          backgroundColor: Colors.grey.shade50,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.05.sh),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'العنوان',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (val) {
                    address = val;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(Constants.mainColor), width: 0.8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Color(Constants.mainColor), width: 0.8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Text(
                  'ملاحظات التوصيل',
                  style: TextStyle(
                      color: Color(Constants.mainColor), fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLines: 4,
                  onChanged: (val) {
                    district = val;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(Constants.mainColor), width: 0.8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Color(Constants.mainColor), width: 0.8),
                    ),
                  ),
                ),
                // Image.network(
                //     'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284 &key=AIzaSyA6pqUxVRxuv5mV0-RWjGl2Qg-wIsZA6PY'),
                SizedBox(
                  height: 0.35.sh,
                ),
                Center(
                  child: BuildIndigoButton(
                      title: 'اضافة',
                      function: () {
                        BlocProvider.of<CartCubit>(context)
                            .addAddress(address: address, district: district)
                            .then((value) => Navigator.of(context).pop());
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
