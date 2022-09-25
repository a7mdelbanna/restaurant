import 'package:flutter/material.dart';

import 'colors.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            scheme.primary.withOpacity(0.7),
            BlendMode.dstATop,
          ),
          image: AssetImage(image),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.subtitle1
                ?.copyWith(color: scheme.surface, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: textTheme.bodyText2?.copyWith(
              color: scheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
