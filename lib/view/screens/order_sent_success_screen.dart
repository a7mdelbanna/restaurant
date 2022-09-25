import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant/view/widgets/custom_app_bar.dart';

import '../widgets/animated_checkmark.dart';

class OrderSuccessScreen extends StatefulWidget {
  OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 500), () {
      loading = false;
      setState(() {});
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(
            customTitle: loading ? Text('') : Text('Success'),
            context: context,
            expandedHeight: kToolbarHeight,
            collapsedHeight: kToolbarHeight,
            appBarElevation: 0,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  AnimatedCheck(),
                  loading
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Wohooo, your order successfully placed',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'You can track your order progress through',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Track Order'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Menu',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.orangeAccent),
                                )),
                          ],
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
