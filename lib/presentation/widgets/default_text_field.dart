import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatelessWidget {
  final String hint;
  final String icon;
  BuildTextField({required this.hint, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        style: TextStyle(fontSize: 20.sp),
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Color(0xffF0F4F8),
            hintText: hint,
            prefixIcon: Image.asset(
              icon,
            ),
            hintStyle: TextStyle(fontSize: 18.sp, color: Color(0xffA6BCD0)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
