import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Utils {
  static normalTextStyle({color, size}) =>
      TextStyle(color: color ?? AppColors.black, fontSize: size ?? 18.0);
}
