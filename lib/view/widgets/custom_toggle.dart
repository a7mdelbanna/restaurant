import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomToggle extends ToggleSwitch {
  CustomToggle(
      {Key? key,
      required this.onTap,
      required this.width,
      required this.initialIndex,
      required this.numberOfSwitches,
      required this.toggleLabels})
      : super(key: key);

  final double width;

  final int initialIndex;
  final int numberOfSwitches;
  final List<String> toggleLabels;
  final Function(int?) onTap;
  @override
  double get animateDuration => 10;
  @override
  bool get animate => true;
  @override
  // TODO: implement radiusStyle
  bool get radiusStyle => true;
  @override
  // TODO: implement minHeight
  double get minHeight => 40;
  @override
  // TODO: implement minWidth
  double get minWidth => width;
  @override
  // TODO: implement cornerRadius
  double get cornerRadius => 15;
  @override
  // TODO: implement activeBgColor
  List<Color>? get activeBgColor => [Colors.amberAccent];
  @override
  // TODO: implement dividerMargin
  double? get dividerMargin => 10;

  @override
  // TODO: implement activeFgColor
  Color? get activeFgColor => Colors.white;
  @override
  // TODO: implement inactiveBgColor
  Color? get inactiveBgColor => Colors.white;
  @override
  // TODO: implement inactiveFgColor
  Color? get inactiveFgColor => Colors.grey[900];
  @override
  // TODO: implement initialLabelIndex
  int? get initialLabelIndex => initialIndex;
  @override
  // TODO: implement totalSwitches
  int? get totalSwitches => numberOfSwitches;
  @override
  // TODO: implement labels
  List<String>? get labels => toggleLabels;
  @override
  // TODO: implement changeOnTap
  bool get changeOnTap => true;
  @override
  // TODO: implement onToggle
  OnToggle? get onToggle => onTap;
}
