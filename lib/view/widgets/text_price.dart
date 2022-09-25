import 'package:flutter/material.dart';

class TextPrice extends StatelessWidget {
  const TextPrice({Key? key, required this.text, required this.price})
      : super(key: key);
  final String text;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 10,
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
        Spacer(),
        SizedBox(
          height: 30,
          width: price.toString().length > 9 ? 120 : 90,
          child: Center(
            child: Text(
              price,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
