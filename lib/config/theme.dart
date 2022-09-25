import 'package:flutter/material.dart';

import 'const.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class CustomTheme {
  static final ThemeData lightTheme = ThemeData().copyWith(
    popupMenuTheme: PopupMenuThemeData(
        color: CustomColors.lightBackgroundColor,
        textStyle: TextStyle(
          color: CustomColors.mainOrange,
        )),
    splashColor: CustomColors.lightSubTextColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedIconTheme: IconThemeData(color: CustomColors.lightSubTextColor),
      selectedIconTheme: IconThemeData(color: CustomColors.mainOrange),
      type: BottomNavigationBarType.shifting,
      elevation: 5,
      unselectedItemColor: CustomColors.lightSubTextColor,
      selectedItemColor: CustomColors.lightActiveButtonColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    ),
    scaffoldBackgroundColor: CustomColors.lightBackgroundColor,
    tabBarTheme: const TabBarTheme(
        unselectedLabelColor: CustomColors.lightSubTextColor,
        labelColor: CustomColors.mainOrange),
    dialogTheme: DialogTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius15),
        ),
        backgroundColor: CustomColors.lightItemCardColor),
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(Sizes.paddingSize10),
      elevation: Sizes.size4,
      color: CustomColors.lightBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    primaryColor: CustomColors.mainOrange,
    backgroundColor: CustomColors.lightBackgroundColor,
    disabledColor: CustomColors.lightInActiveButtonColor,
    dividerColor: CustomColors.lightTextFieldIconColor,

    chipTheme: ChipThemeData(
      labelStyle: TextStyle(color: CustomColors.mainOrange),
      backgroundColor: CustomColors.lightBackgroundColor,
      selectedColor: CustomColors.mainOrange,
      elevation: 0,
      padding: const EdgeInsets.all(Sizes.paddingSize2),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: CustomColors.mainOrange),
        borderRadius: BorderRadius.circular(Sizes.radius10),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: CustomColors.lightActiveButtonColor,
      disabledColor: CustomColors.lightInActiveButtonColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(300, 45),
        minimumSize: const Size(200, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius15),
        ),
        elevation: Sizes.buttonElevation4,
        primary: CustomColors.lightActiveButtonColor,
        textStyle: TextStyle(
          fontSize: Sizes.fontSize16,
          color: CustomColors.lightMainButtonTextColor,
          fontWeight: FontW.regular,
        ),
      ),
    ),
    textTheme: const TextTheme().copyWith(

      headline1: TextStyle(
          color: Colors.black,
          fontSize: Sizes.fontSize32,
          fontWeight: FontW.semiBold),
      headline2: TextStyle(
          color: Colors.black,
          fontSize: Sizes.fontSize20,
          fontWeight: FontW.semiBold),
      headline3: TextStyle(
          color: Colors.black,
          fontSize: Sizes.fontSize18,
          fontWeight: FontW.regular),
      headline4: TextStyle(
          color: CustomColors.lightBackgroundColor,
          fontSize: Sizes.fontSize20,
          fontWeight: FontW.regular),
      headline5: TextStyle(
          color: Colors.black,
          fontSize: Sizes.fontSize16,
          fontWeight: FontW.semiBold),
      headline6: TextStyle(
          color: CustomColors.lightSubTextColor,
          fontSize: Sizes.fontSize16,
          fontWeight: FontW.regular),
      subtitle1: TextStyle(
          color: CustomColors.lightSubTextColor,
          fontSize: Sizes.fontSize14,
          fontWeight: FontW.regular),
      subtitle2: TextStyle(
          color: CustomColors.lightBackgroundColor,
          fontSize: Sizes.fontSize16,
          fontWeight: FontW.regular),
      bodyText1: TextStyle(
          color: Colors.black,
          fontSize: Sizes.fontSize16,
          fontWeight: FontW.regular),
      bodyText2: TextStyle(
          color: Colors.black,
          fontSize: Sizes.fontSize12,
          fontWeight: FontW.light),
    ),
    // iconTheme: const IconThemeData(
    //   color: CustomColors.lightPrimaryColor,
    //   size: Sizes.iconSize22,
    // ),
    iconTheme: IconThemeData(color: CustomColors.mainOrange),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(
          top: Sizes.paddingSize4,
          right: Sizes.paddingSize10,
          bottom: Sizes.paddingSize4,
          left: Sizes.paddingSize4),
      filled: true,
      fillColor: CustomColors.lightTextFieldFilledColor,
      iconColor: CustomColors.lightTextFieldIconColor,
      prefixStyle: TextStyle(
        color: CustomColors.lightTextFieldHintColor,
        fontSize: Sizes.fontSize14,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.radius10),
        borderSide: const BorderSide(
            color: CustomColors.lightFocusedTextFieldBorderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.radius10),
        borderSide: const BorderSide(color: CustomColors.darkSubTextColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.radius10),
        borderSide: const BorderSide(color: CustomColors.darkSubTextColor),
      ),
      hintStyle: TextStyle(
        color: CustomColors.lightTextFieldHintColor,
        fontSize: Sizes.fontSize14,
      ),
      suffixIconColor: CustomColors.lightTextFieldIconColor,
    ),
  );
  static final ThemeData darkTheme = ThemeData().copyWith(
    popupMenuTheme: PopupMenuThemeData(
        color: CustomColors.lightBackgroundColor,
        textStyle: TextStyle(
          color: CustomColors.darkBackgroundColor,
        )),
    dialogBackgroundColor: CustomColors.darkItemCardColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: CustomColors.darkMainTextColor,
      unselectedItemColor: CustomColors.darkSubTextColor,
      unselectedIconTheme: IconThemeData(color: CustomColors.darkSubTextColor),
      selectedIconTheme: IconThemeData(color: CustomColors.darkMainTextColor),
      backgroundColor: CustomColors.darkBackgroundColor,
      elevation: 5,
    ),
    scaffoldBackgroundColor: CustomColors.darkBackgroundColor,
    indicatorColor: Colors.deepPurpleAccent,
    tabBarTheme: const TabBarTheme(
        unselectedLabelColor: Colors.grey,
        labelColor: CustomColors.darkMainTextColor),
    dialogTheme: DialogTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius15),
        ),
        backgroundColor: CustomColors.darkItemCardColor),
    chipTheme: ChipThemeData(
      backgroundColor: CustomColors.lightBackgroundColor,
      selectedColor: CustomColors.lightBackgroundColor,
      elevation: 0,
      padding: const EdgeInsets.all(Sizes.paddingSize2),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: CustomColors.lightBackgroundColor),
        borderRadius: BorderRadius.circular(Sizes.radius10),
      ),
    ),
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(Sizes.paddingSize10),
      elevation: Sizes.size4,
      color: CustomColors.darkItemCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    dividerColor: CustomColors.darkTextFieldIconColor,
    primaryColor: CustomColors.darkPrimaryColor,
    backgroundColor: CustomColors.darkBackgroundColor,
    disabledColor: CustomColors.darkInActiveButtonColor,
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: CustomColors.darkActiveButtonColor,
      disabledColor: CustomColors.lightInActiveButtonColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(300, 45),
        onPrimary: Colors.white,
        onSurface: Colors.white,
        maximumSize: const Size(400, 45),
        minimumSize: const Size(330, 45),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(Sizes.radius15),
        ),
        elevation: Sizes.buttonElevation4,
        primary: CustomColors.darkBackgroundColor,
        textStyle: TextStyle(
          fontSize: Sizes.fontSize16,
          color: Colors.black,
          fontWeight: FontW.regular,
        ),
      ),
    ),
    textTheme: const TextTheme().copyWith(
      headline1: TextStyle(
          color: CustomColors.darkMainTextColor,
          fontSize: Sizes.fontSize32,
          fontWeight: FontW.bold),
      headline2: TextStyle(
          color: CustomColors.darkMainTextColor,
          fontSize: Sizes.fontSize22,
          fontWeight: FontW.bold),
      headline3: TextStyle(
          color: CustomColors.darkMainTextColor,
          fontSize: Sizes.fontSize18,
          fontWeight: FontW.bold),
      headline4: TextStyle(
          color: CustomColors.darkSubTextColor,
          fontSize: Sizes.fontSize14,
          fontWeight: FontW.regular),
      subtitle1: TextStyle(
          color: CustomColors.darkSubTextColor,
          fontSize: Sizes.fontSize14,
          fontWeight: FontW.regular),
      bodyText1: TextStyle(
          color: CustomColors.darkMainTextColor,
          fontSize: Sizes.fontSize14,
          fontWeight: FontW.regular),
      bodyText2: TextStyle(
          color: CustomColors.darkSubTextColor,
          fontSize: Sizes.fontSize16,
          fontWeight: FontW.regular),
    ),
    iconTheme: const IconThemeData(color: CustomColors.lightBackgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(
          top: Sizes.paddingSize4,
          right: Sizes.paddingSize10,
          bottom: Sizes.paddingSize4,
          left: Sizes.paddingSize4),
      filled: true,
      fillColor: CustomColors.darkTextFieldFilledColor,
      iconColor: CustomColors.darkTextFieldIconColor,
      prefixStyle: TextStyle(
        color: CustomColors.darkTextFieldHintColor,
        fontSize: Sizes.fontSize14,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.radius15),
        borderSide: const BorderSide(
            color: CustomColors.darkFocusedTextFieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.radius15),
        borderSide:
            const BorderSide(color: CustomColors.darkTextFieldFilledColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.radius10),
        borderSide:
            const BorderSide(color: CustomColors.darkTextFieldFilledColor),
      ),
      hintStyle: TextStyle(
        color: CustomColors.lightTextFieldHintColor,
        fontSize: Sizes.fontSize14,
      ),
      suffixIconColor: CustomColors.darkTextFieldIconColor,
    ),
  );
  get lightMode {
    return lightTheme;
  }

  get darkMode {
    return darkTheme;
  }
}
