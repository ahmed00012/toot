import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/presentation/screens/payment_screen.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/delivery_app_bar.dart';
import 'package:toot/presentation/widgets/single_choice_delivery.dart';

class DeliveryOptionsScreen extends StatefulWidget {
  final int id;
  DeliveryOptionsScreen({required this.id});
  @override
  _DeliveryOptionsScreenState createState() => _DeliveryOptionsScreenState();
}

class _DeliveryOptionsScreenState extends State<DeliveryOptionsScreen> {
  List<bool> selections = List<bool>.filled(2, false, growable: false);
  bool isExpanded = false;
  int? id;
  String? date;

  List<bool> singleSelection(bool selection, int index) {
    if (selections.contains(true)) {
      int i = selections.indexOf(true);
      selections[i] = false;
      selections[index] = true;
    } else {
      selections[index] = selection;
    }
    setState(() {
      if (index == 1) {
        isExpanded = true;
      } else {
        isExpanded = false;
      }
    });
    print(selections);
    return selections;
  }

  @override
  void initState() {
    print(widget.id);
    BlocProvider.of<CartCubit>(context).fetchDatesAndTimes(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildDeliveryBar(
        title: 'خيارات التوصيل',
        isDelivery: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is InfoLoaded) {
            final info = state.info;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    Text(
                      'موعد التوصيل',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChoiceDelivery(
                          function: singleSelection,
                          choicesList: selections,
                          index: 0,
                          title: "توصيل الان",
                        ),
                        SingleChoiceDelivery(
                          function: singleSelection,
                          choicesList: selections,
                          index: 1,
                          title: "توصيل لاحقا",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.025.sh,
                    ),
                    !isExpanded
                        ? SizedBox(
                            height: 0.3.sh,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Text(
                                  'اختيار التاريخ',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                              Container(
                                height: 0.06.sh,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: info.dates!
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                date = DateFormat('yyyy-MM-dd')
                                                    .format(e);
                                              });
                                            },
                                            child: BuildDayItem(
                                              day: DateFormat('yyyy-MM-dd')
                                                  .format(e),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 10),
                                child: Text(
                                  'اختيار الوقت',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                              Container(
                                height: 0.06.sh,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: info.times!
                                      .map((e) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              id = e.id;
                                            });
                                          },
                                          child: BuildDayItem(
                                            day: e.duration!,
                                          )))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.05.sh),
                      child: BuildIndigoButton(
                          title: 'استمرار',
                          function: () {
                            BlocProvider.of<CartCubit>(context)
                                .confirmInfoDateAndTime(date: date, id: id);
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (_) => PaymentScreen()))
                                .then((value) =>
                                    BlocProvider.of<CartCubit>(context)
                                        .emit(InfoLoaded(info: info)));
                          }),
                    )
                  ],
                ),
              ),
            );
          } else {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0,
              content: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/loading.gif',
                    height: 0.4.sw,
                    width: 0.4.sw,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class BuildDayItem extends StatelessWidget {
  final String day;

  BuildDayItem({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 0.26.sw,
      decoration: BoxDecoration(
          color: Color(0xffF0F4F8), borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text(
        day,
        style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w300),
      )),
    );
  }
}
