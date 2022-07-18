import 'package:flutter/material.dart';

class AppInputBorder {
  static const enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFC2C9D1), width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black45, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE02424), width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const disabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE02424), width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const focusedErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE02424), width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}