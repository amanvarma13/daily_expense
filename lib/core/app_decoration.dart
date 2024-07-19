import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimen.dart';

class AppDecoration{

  ///   Email text field decoration
  static InputDecoration textFieldInputDecoration(String hintText ,BuildContext context){
    return InputDecoration(
      fillColor: AppColors().white,
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimen.circular10),
        borderSide: BorderSide(color: AppColors().red1, width: 2)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimen.circular10),
        borderSide: BorderSide(color: AppColors().black1, width: 2)),
      filled: false,
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors().grey2),
      labelStyle: TextStyle(color: AppColors().grey2),
      enabledBorder: OutlineInputBorder(gapPadding: 1,
        borderRadius: BorderRadius.circular(AppDimen.circular10),
        borderSide: BorderSide(color: AppColors().black1, width: 2)
      ),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimen.circular10),
        borderSide: BorderSide(color: AppColors().black1, width: 2)
      ),
    );
  }
}