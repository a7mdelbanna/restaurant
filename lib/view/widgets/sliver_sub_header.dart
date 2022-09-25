import 'dart:math';

import 'package:flutter/material.dart';

class SliverSubHeader extends StatelessWidget {
  final Widget widget;

  SliverSubHeader({required this.widget});

  @override
  Widget build(BuildContext context) {
    // 1
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        // 2
        minHeight: 50,
        maxHeight: 50,
        // 3
        child: Container(
          child: widget,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
