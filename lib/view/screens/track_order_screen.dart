import 'package:flutter/material.dart';
import 'package:restaurant/view/widgets/custom_app_bar.dart';
import 'package:timeline_tile/timeline_tile.dart';

// class MyDemoPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Showcase(
//       title: 'Delivery Timeline',
//       app: _DeliveryTimelineApp(),
//       description:
//       'A simple timeline with few steps to show the current status of '
//           'an order.',
//       template: SimpleTemplate(reverse: false),
//       theme: TemplateThemeData(
//         frameTheme: FrameThemeData(
//           statusBarBrightness: Brightness.dark,
//           frameColor: const Color(0xFF215C3F),
//         ),
//         flutterLogoColor: FlutterLogoColor.original,
//         brightness: Brightness.dark,
//         backgroundColor: const Color(0xFFE9E9E9),
//         titleTextStyle: GoogleFonts.neuton(
//           fontSize: 80,
//           fontWeight: FontWeight.bold,
//           color: const Color(0xFF2C7B54),
//         ),
//         descriptionTextStyle: GoogleFonts.yantramanav(
//           fontSize: 24,
//           height: 1.2,
//           color: const Color(0xFF2C7B54),
//         ),
//         buttonTextStyle: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 2,
//         ),
//         buttonIconTheme: const IconThemeData(color: Colors.white),
//         buttonTheme: ButtonThemeData(
//           buttonColor: const Color(0xFF2C7B54),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//           padding: const EdgeInsets.all(16),
//         ),
//       ),
//       links: [
//         LinkData.github('https://github.com/JHBitencourt/timeline_tile'),
//       ],
//       logoLink: LinkData(
//         icon: Image.asset(
//           'assets/built_by_jhb_black.png',
//           fit: BoxFit.fitHeight,
//         ),
//         url: 'https://github.com/JHBitencourt',
//       ),
//     );
//   }
// }
//
// class _DeliveryTimelineApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Delivery TimelineTile',
//       builder: Frame.builder,
//       home: _DeliveryTimeline(),
//     );
//   }
// }

class MyDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF379A69),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF27AA69).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: <Widget>[
                CustomAppBar(
                    customTitle: Text(
                      'Order Tracking',
                      style: TextStyle(color: Colors.black),
                    ),
                    context: context,
                    expandedHeight: kToolbarHeight,
                    collapsedHeight: kTextTabBarHeight),
                SliverToBoxAdapter(child: _Header()),
                _DeliveryTimeline(),
                SliverToBoxAdapter(
                  child: Center(
                      child: TextButton(
                    child: Text(
                      'Track order on map',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.deepOrangeAccent),
                    ),
                    onPressed: () {},
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'ESTIMATED TIME',
                    style: TextStyle(
                      color: const Color(0xFFA2A2A2),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '50 minutes',
                    style: TextStyle(
                      color: const Color(0xFF636564),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'ORDER CODE',
                    style: TextStyle(
                      color: const Color(0xFFA2A2A2),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '#2482011',
                    style: TextStyle(
                      color: const Color(0xFF636564),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const deliverySteps = [
  'Order Placed',
  'Order Confirmed',
  'Preparing the order',
  'Ready to Pickup',
];

class _DeliveryTimeline extends StatefulWidget {
  const _DeliveryTimeline();

  @override
  _DeliveryTimelineState createState() => _DeliveryTimelineState();
}

class _DeliveryTimelineState extends State<_DeliveryTimeline> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    currentStep += 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: deliverySteps.length,
          (context, index) {
        final step = deliverySteps[index];
        var indicatorSize = 30.0;
        var beforeLineStyle = LineStyle(
          color: Colors.white.withOpacity(0.8),
        );

        _DeliveryStatus status;
        LineStyle afterLineStyle;
        if (index < currentStep) {
          status = _DeliveryStatus.done;
          beforeLineStyle = LineStyle(color: Colors.deepOrangeAccent);
          afterLineStyle = LineStyle(color: Colors.deepOrangeAccent);
        } else if (index > currentStep) {
          status = _DeliveryStatus.todo;
          indicatorSize = 20;
          beforeLineStyle = const LineStyle(color: Color(0xFF747888));
          afterLineStyle = const LineStyle(color: Color(0xFF747888));
        } else {
          beforeLineStyle = const LineStyle(color: Colors.deepOrangeAccent);
          afterLineStyle = const LineStyle(color: Color(0xFF747888));
          status = _DeliveryStatus.doing;
        }

        return Container(
          height: 100,
          child: TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.32,
            isFirst: index == 0,
            isLast: index == deliverySteps.length - 1,
            beforeLineStyle: beforeLineStyle,
            afterLineStyle: afterLineStyle,
            indicatorStyle: IndicatorStyle(
              width: indicatorSize,
              height: indicatorSize,
              indicator: _IndicatorDelivery(status: status),
            ),
            startChild: _EndChildDelivery(
              text: step,
              current: index == currentStep,
            ),
            endChild: _StartChildDelivery(index: index),
          ),
        );
      }),
    );
  }
}

enum _DeliveryStatus { done, doing, todo }

class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        child: Center(
          child: index == 0
              ? Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset('assets/images/order_placed.png', height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Receiving your order',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Center(
                              child: Text('Estimated Time:1 min',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.grey)),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              : index == 1
                  ? Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset('assets/images/order_confirmed.png',
                            height: 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Order Confirming',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: Text('Estimated Time:2 mins',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.grey)),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  : index == 2
                      ? Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Image.asset('assets/images/order_processed.png',
                                height: 45),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Preparing your order',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Center(
                                      child: Text('Estimated Time:30 mins',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.grey)),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Image.asset('assets/images/ready_to_pickup.png',
                                height: 45),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Ready to be delivered',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(color: Colors.black),
                                        softWrap: true,
                                      ),
                                    ),
                                    Center(
                                      child: Text('Estimated Time: 17mins',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.grey)),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
        ),
      ),
    );
  }
}

class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
    required this.text,
    required this.current,
  });

  final String text;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: current ? const Color(0xFF2ACA8E) : Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({required this.status});

  final _DeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrangeAccent,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orangeAccent,
          ),
          child: const Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF747888),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5D6173),
              ),
            ),
          ),
        );
    }
  }
}
//class _TimelineDelivery extends StatefulWidget {
//   @override
//   State<_TimelineDelivery> createState() => _TimelineDeliveryState();
// }
//
// class _TimelineDeliveryState extends State<_TimelineDelivery> {
//   bool orderPlacedDisabled = true;
//   bool orderPlacedLoading = false;
//   bool orderConfirmedDisabled = true;
//   bool orderProcessedDisabled = true;
//   bool orderIsReadyDisabled = true;
//   @override
//   void initState() {
//     Future.delayed(Duration(seconds: 5));
//     orderPlacedDisabled = false;
//     Future.delayed(Duration(seconds: 5));
//     orderConfirmedDisabled = false;
//     Future.delayed(Duration(seconds: 5));
//     orderProcessedDisabled = false;
//     Future.delayed(Duration(seconds: 5));
//     orderIsReadyDisabled = false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//         shrinkWrap: true,
//         children: <Widget>[
//           TimelineTile(
//             alignment: TimelineAlign.manual,
//             lineXY: 0.1,
//             isFirst: true,
//             indicatorStyle: IndicatorStyle(
//               iconStyle:
//                   IconStyle(iconData: Icons.receipt, color: Colors.white),
//               width: 40,
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//               padding: EdgeInsets.all(6),
//             ),
//             endChild: Column(
//               children: [
//                 _RightChild(
//                   disabled: orderPlacedDisabled ? false : true,
//                   asset: 'assets/images/order_placed.png',
//                   title: 'Order Placed',
//                   message: 'We have received your order.',
//                 ),
//               ],
//             ),
//             beforeLineStyle: LineStyle(
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//             ),
//           ),
//           TimelineTile(
//             alignment: TimelineAlign.manual,
//             lineXY: 0.1,
//             indicatorStyle: IndicatorStyle(
//               width: 20,
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//               padding: EdgeInsets.all(6),
//             ),
//             endChild: _RightChild(
//               disabled: orderConfirmedDisabled ? false : true,
//               asset: 'assets/images/order_confirmed.png',
//               title: 'Order Confirmed',
//               message: 'Your order has been confirmed.',
//             ),
//             beforeLineStyle: LineStyle(
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//             ),
//           ),
//           TimelineTile(
//             alignment: TimelineAlign.manual,
//             lineXY: 0.1,
//             indicatorStyle: IndicatorStyle(
//               width: 20,
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//               padding: EdgeInsets.all(6),
//             ),
//             endChild: _RightChild(
//               disabled: orderProcessedDisabled ? false : true,
//               asset: 'assets/images/order_processed.png',
//               title: 'Order Processed',
//               message: 'We are preparing your order.',
//             ),
//             beforeLineStyle: LineStyle(
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//             ),
//             afterLineStyle: LineStyle(
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//             ),
//           ),
//           TimelineTile(
//             alignment: TimelineAlign.manual,
//             lineXY: 0.1,
//             isLast: true,
//             indicatorStyle: IndicatorStyle(
//               width: 20,
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//               padding: EdgeInsets.all(6),
//             ),
//             endChild: _RightChild(
//               disabled: orderIsReadyDisabled ? false : true,
//               asset: 'assets/images/ready_to_pickup.png',
//               title: 'Ready to Pickup',
//               message: 'Your order is ready for pickup.',
//             ),
//             beforeLineStyle: LineStyle(
//               color:
//                   orderPlacedDisabled ? Color(0xFFDADADA) : Color(0xFF27AA69),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _RightChild extends StatelessWidget {
//   const _RightChild({
//     required this.asset,
//     required this.title,
//     required this.message,
//     this.disabled = false,
//   });
//
//   final String asset;
//   final String title;
//   final String message;
//   final bool disabled;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: <Widget>[
//           Opacity(
//             child: Image.asset(asset, height: 50),
//             opacity: disabled ? 0.5 : 1,
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: disabled
//                       ? const Color(0xFFBABABA)
//                       : const Color(0xFF636564),
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 message,
//                 style: TextStyle(
//                   color: disabled
//                       ? const Color(0xFFD5D5D5)
//                       : const Color(0xFF636564),
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// class _AppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: const Color(0xFF27AA69),
//       leading: const Icon(Icons.menu),
//       actions: <Widget>[
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Text(
//               'CANCEL',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//       title: Text(
//         'Track Order',
//         style: TextStyle(
//             color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
//
