import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/screens/auth_screen.dart';
import 'package:toot/presentation/widgets/default_indigo_button.dart';
import 'package:toot/presentation/widgets/text_button.dart';
import '../../constants.dart';

class ImagesSlider extends StatefulWidget {
  final List<String> imagesPreview;
  final List<String> title;
  ImagesSlider({required this.imagesPreview, required this.title});

  @override
  _ImagesSliderState createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 0.82.sh,
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
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: widget.imagesPreview.length,
                options: CarouselOptions(
                    height: 0.62.sh,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                itemBuilder: (ctx, index, _) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              widget.imagesPreview[index],
                              fit: BoxFit.contain,
                              width: 0.8.sw,
                              height: 0.4.sh,
                            )),
                        SizedBox(
                          height: 0.1.sh,
                        ),
                        Expanded(
                          child: Text(
                            widget.title[index],
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(Constants.mainColor)),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 15,
                child: ListView(
                  shrinkWrap: true, scrollDirection: Axis.horizontal,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imagesPreview.map((e) {
                    int index = widget.imagesPreview.indexOf(e);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.only(bottom: 8, right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color(Constants.mainColor)
                            : Colors.grey.shade400,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.04.sh,
        ),
        _current + 1 == widget.imagesPreview.length
            ? BuildIndigoButton(
                title: 'البدء',
                function: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AuthScreen ()));
                })
            : BuildTextButton(
                title: 'تخطي',
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AuthScreen()));
                })
      ],
    );
  }
}
