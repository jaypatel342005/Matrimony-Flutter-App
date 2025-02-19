import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/utils/constants/colors.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/text_theme.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/outlined_button_theme.dart';

class TAppTheme {
  TAppTheme._(); // Private constructor to avoid instantiation

  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.lightContainer,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    // textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    // floatingActionButtonTheme: TFloatingActionButtonTheme.lightFloatingActionButtonTheme,
    // sliderTheme: TSliderTheme.lightSliderTheme,
    // switchTheme: TSwitchTheme.lightSwitchTheme,
    // iconTheme: TIconTheme.lightIconTheme,
    // listTileTheme: TListTileTheme.lightListTileTheme,
    // dialogTheme: TDialogTheme.lightDialogTheme,
  );

  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: TColors.darkContainer,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    // textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
    // floatingActionButtonTheme: TFloatingActionButtonTheme.darkFloatingActionButtonTheme,
    // sliderTheme: TSliderTheme.darkSliderTheme,
    // switchTheme: TSwitchTheme.darkSwitchTheme,
    // iconTheme: TIconTheme.darkIconTheme,
    // listTileTheme: TListTileTheme.darkListTileTheme,
    // dialogTheme: TDialogTheme.darkDialogTheme,
  );
}
