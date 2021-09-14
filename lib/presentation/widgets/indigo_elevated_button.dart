import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildElevatedButton extends StatelessWidget {
  final String title;
  final Function function;
  BuildElevatedButton({required this.function, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.35.sw,
      child: ElevatedButton(
        onPressed: () {
          return function();
        },
        child: Text(title),
        style: ElevatedButton.styleFrom(
          primary: Color(Constants.mainColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
