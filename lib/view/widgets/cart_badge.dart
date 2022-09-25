import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/const.dart';

class Badge extends StatelessWidget {
  Badge({
    required this.child,
    required this.value,
    this.color = Colors.deepOrange,
  });

  final Widget child;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.zero,
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.radius10.r),
              color: Colors.orangeAccent,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: Sizes.fontSize10,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
