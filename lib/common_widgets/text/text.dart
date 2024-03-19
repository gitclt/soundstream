import 'package:flutter/material.dart';

Text blackText(
  String label,
  double fontSize, {
  TextAlign? textAlign,
  FontWeight? fontWeight = FontWeight.w400,
  TextOverflow? textOverflow,
}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: 'Manrope',
        overflow: textOverflow,
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}
Text colorText(
  String label,
  
  double fontSize, {
  TextAlign? textAlign,
  FontWeight? fontWeight = FontWeight.w400,
  TextOverflow? textOverflow,
  Color color = Colors.blue,
}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: 'Manrope',
        overflow: textOverflow,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}