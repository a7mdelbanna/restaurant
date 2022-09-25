import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color? iconColor;
  final boxShape;

  final Color? backgroundColor;

  const CustomIconButton({
    Key? key,
    required this.boxShape,
    required this.icon,
    required this.onTap,
    required this.size,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: boxShape,
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
      ),
    );
  }
}

class RectangularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color? iconColor;

  final Color? backgroundColor;

  const RectangularIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.size,
    required this.iconColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        child: Card(
          color: backgroundColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: backgroundColor!),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}
