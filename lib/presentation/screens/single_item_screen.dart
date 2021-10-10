import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toot/cubits/cart_cubit/cart_cubit.dart';
import 'package:toot/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:toot/cubits/product_cubit/product_cubit.dart';
import 'package:toot/data/models/check_box_state.dart';
import 'package:toot/presentation/screens/auth_screen.dart';
import 'package:toot/presentation/widgets/blurry_dialog.dart';

import '../../constants.dart';

class SingleItemScreen extends StatefulWidget {
  final int id;
  final String title;
  final double price;
  final int shopId;
  final bool isFav;
  final bool? isEditable;
  SingleItemScreen(
      {required this.id,
      required this.title,
      required this.price,
      required this.shopId,
      required this.isFav,
      this.isEditable = false});

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  late bool isFav;
  int quantity = 1;
  String? dropdownPriceValue;
  List prices = [];
  List chosenExtra = [];
  List extra = [];
  final _formKey = GlobalKey<FormState>();
  List<String> images = [];
  double price = 0.00;
  int current = 0;

  addExtrasPrice(double extraPrice, bool incremental) {
    if (incremental) {
      setState(() {
        this.price = this.price + extraPrice;
      });
    } else {
      setState(() {
        this.price = this.price - extraPrice;
      });
    }
  }

  _showDialog(BuildContext context, String title) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AuthScreen())),
          // code on continue comes here
        };

    BlurryDialog alert = BlurryDialog('التسجيل اولا', title, continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).fetchItemDetails(widget.id);
    price = widget.price;
    this.isFav = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              color: Color(Constants.mainColor), fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Color(Constants.mainColor), size: 25),
          splashRadius: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border_outlined,
              color: Colors.red,
            ),
            onPressed: () async {
              if (await FlutterSecureStorage().read(key: 'token') == null) {
                _showDialog(context,
                    'لا يمكن الاضافه الي المفضلة يجب عليك التسجيل اولا');
              } else {
                BlocProvider.of<FavoritesCubit>(context)
                    .toggleFavoriteStatus(itemId: widget.id)
                    .then((value) => setState(() {
                          isFav = !isFav;
                        }));
              }
            },
          )
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is ItemDetailsLoaded) {
          final item = state.itemDetails;

          extra = state.itemDetails.addon!
              .map((extra) => CheckBoxState(
                  name: '${extra.nameAr}   + ${extra.price}  RS ',
                  price: double.parse(extra.price!)))
              .toList();

          if (item.imageOne != null) {
            images.add(item.imageOne!);
          }
          if (item.imageTwo != null) {
            images.add(item.imageTwo!);
          }
          if (item.imageThree != null) {
            images.add(item.imageThree!);
          }
          return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: CarouselSlider.builder(
                        itemCount: images.length,
                        options: CarouselOptions(
                            height: 0.4.sh,
                            autoPlay: true,
                            viewportFraction: 0.9,
                            autoPlayInterval: Duration(seconds: 8),
                            onPageChanged: (index, reason) {
                              setState(() {
                                current = index;
                              });
                            }),
                        itemBuilder: (ctx, index, _) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  images[index],
                                  fit: BoxFit.fitHeight,
                                  width: 0.9.sw,
                                )),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 0.03.sh, top: 0.05.sh),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    price == 0.00
                                        ? Text(
                                            'السعر يعتمد علي اختياراتك',
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff4A4B4D)),
                                          )
                                        : Text(
                                            (price * quantity).toString() +
                                                " RS ",
                                            style: TextStyle(
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff4A4B4D)),
                                          ),
                                    Visibility(
                                      visible: price != 0.00,
                                      child: Text(' لكل/ ${item.unit}',
                                          style: TextStyle(
                                            color: Color(0xff4A4B4D),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: extra.isNotEmpty,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                ' يمكنك اختيار ${item.unit} :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff4A4B4D),
                                    fontSize: 18.sp),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: item.options!.isNotEmpty,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 0.06.sw, right: 0.02.sw),
                                    filled: true,
                                    fillColor: Color(0xffF0F4F8),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide.none),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none)),
                                validator: (value) => value == null
                                    ? 'من فضلك اختار من بين الانواع'
                                    : null,
                                isExpanded: true,
                                value: dropdownPriceValue,
                                hint: Text(
                                  '${item.options![0].textAr!}  ${item.options![0].price.toString()} RS',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff4A4B4D)),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 28,
                                  color: Color(Constants.mainColor),
                                ),
                                iconSize: 24,
                                elevation: 4,
                                style: TextStyle(
                                    color: Color(Constants.mainColor),
                                    fontSize: 16),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    price = double.parse(newValue!);
                                  });
                                },
                                items: item.options!
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.price,
                                    child: Text(
                                        '${value.textAr}  ${value.price} RS '),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                extra.isNotEmpty && item.options!.isNotEmpty,
                            child: SizedBox(
                              height: 0.05.sh,
                            ),
                          ),
                          Visibility(
                            visible: extra.isNotEmpty,
                            child: Text(
                              'يمكنك الاختيار من الاضافات :',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff4A4B4D),
                                  fontSize: 18.sp),
                            ),
                          ),
                          ...extra.map((e) => BuildCheckboxListTile(
                                checkBoxState: e,
                                function: addExtrasPrice,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.03.sh),
                            child: Container(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffF0F4F8),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      splashRadius: 1,
                                      icon: Icon(
                                        Icons.add,
                                        size: 24,
                                        color: Color(Constants.mainColor),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Color(Constants.mainColor),
                                      ),
                                    ),
                                    IconButton(
                                      splashRadius: 1,
                                      icon: Icon(
                                        Icons.remove,
                                        size: 24,
                                        color: Color(Constants.mainColor),
                                      ),
                                      onPressed: () {
                                        if (quantity == 1) {
                                          return;
                                        } else {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, cartState) {
                              return Container(
                                width: 1.sw,
                                height: 0.07.sh,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.isEditable!) {
                                        BlocProvider.of<CartCubit>(context)
                                            .removeFromCart(
                                                productId:
                                                    state.itemDetails.id);
                                      }
                                      print('shopId');
                                      print(widget.shopId);
                                      BlocProvider.of<CartCubit>(context)
                                          .addToCart(
                                              shopId: widget.shopId,
                                              productId: state.itemDetails.id,
                                              quantity: quantity)
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Color(Constants.mainColor),
                                                content: Text(
                                                    'تم اضافة المنتج الي السلة بنجاح.')));
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(Constants.mainColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: cartState is CartLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_shopping_cart,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 10),
                                              Text(widget.isEditable!
                                                  ? 'تعديل'
                                                  : 'اضافة الي السله')
                                            ],
                                          )),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 12),
                            child: Text(
                              'الوصف',
                              style: TextStyle(
                                  color: Color(Constants.mainColor),
                                  fontSize: 21.sp),
                            ),
                          ),
                          Html(
                            data: item.description!,
                            shrinkWrap: true,
                          ),
                          SizedBox(
                            height: 0.1.sh,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
      }),
    );
  }
}

class BuildCheckboxListTile extends StatefulWidget {
  final CheckBoxState checkBoxState;
  final Function function;
  BuildCheckboxListTile(
      {context, required this.checkBoxState, required this.function});

  @override
  State<BuildCheckboxListTile> createState() => _BuildCheckboxListTileState();
}

class _BuildCheckboxListTileState extends State<BuildCheckboxListTile> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(
          widget.checkBoxState.name,
          style: TextStyle(fontSize: 16.sp),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: isAdded,
        onChanged: (value) {
          setState(() {
            isAdded = value!;
            print(isAdded);
            if (isAdded == true) {
              return widget.function(widget.checkBoxState.price, true);
            } else {
              return widget.function(widget.checkBoxState.price, false);
            }
          });
        });
  }
}
