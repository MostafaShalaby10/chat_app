import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultText({
  required String text,
  required int fontSize,
  FontWeight fontWeight = FontWeight.w500,
  Color color = Colors.black,
  TextAlign? textAlign = TextAlign.center,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget defaultTextFormField({
  required String hintText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required bool obscureText,
  IconButton? suffixIcon,
  required Icon? prefixIcon,
}) {
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return "$hintText is required";
      }
      return null;
    },
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon:  suffixIcon ,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.black,
        )
      ),
    ),
  );
}

Widget defaultButton({
  required String text,
  int fontSize = 18,
  required Function() onPressed,
  required Color color,
}) {
  return MaterialButton(
    height: 40.h,
    color: color,
    shape: OutlineInputBorder(

      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    onPressed: onPressed,
    child: defaultText(text: text, fontSize: fontSize),
  );
}
