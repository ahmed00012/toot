import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/screens/auth_screen.dart';

import '../../constants.dart';

class ImagesSlider extends StatefulWidget {
  final List<dynamic> imagesPreview;
  ImagesSlider({required this.imagesPreview});

  @override
  _ImagesSliderState createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imagesPreview.length,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
              height: 1.sh,
              enlargeCenterPage: true,
              disableCenter: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          itemBuilder: (ctx, index, _) {
            return SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Image.network(
                widget.imagesPreview[index],
                fit: BoxFit.fill,
              ),
            );
          },
        ),
        Container(
          height: 0.22.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 0.8.sw,
                height: 0.06.sh,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => AuthScreen()));
                  },
                  child: Text('البدء'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 0.8.sw,
                height: 0.06.sh,
                child: ElevatedButton(
                  onPressed: () {
                    buttonCarouselController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                  child: Text('التالي'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
