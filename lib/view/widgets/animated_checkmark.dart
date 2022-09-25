import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedCheck extends StatefulWidget {
  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 400), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  late AnimationController colorController;
  late Animation<Color?> colorAnimation;
  bool _isLoading = true;
  Color color = Colors.grey;
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
        scaleController.forward();
      });
    });
    // colorController =
    //     AnimationController(duration: const Duration(seconds: 1), vsync: this);
    // colorAnimation = ColorTween(begin: Colors.grey, end: Colors.green)
    //     .animate(colorController)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    // colorController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     scaleController.forward();
    //   }
    // });
  }

  Color containerColor = Colors.grey;
  @override
  void dispose() {
    scaleController.dispose();
    colorController.dispose();
    checkController.dispose();
    super.dispose();
  }

  double circleSize = 140;
  double iconSize = 108;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
          )
        : Container(
            child: Stack(
              children: [
                Center(
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: Container(
                      height: circleSize,
                      width: circleSize,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizeTransition(
                    sizeFactor: checkAnimation,
                    axis: Axis.horizontal,
                    axisAlignment: -1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 13,
                        ),
                        Center(
                          child: Icon(Icons.check,
                              color: Colors.white, size: iconSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
