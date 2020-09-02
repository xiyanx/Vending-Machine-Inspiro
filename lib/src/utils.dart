import 'package:flutter/material.dart';

String convertKeRupiah(int amount) => (amount).toStringAsFixed(3);

double getScreenWidth(BuildContext context) {
  final double screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  return screenWidth;
}