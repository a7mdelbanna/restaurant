import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/view/widgets/progress_indicator.dart';

import '../../config/const.dart';
import '../../data/model/order_model.dart';
//
// showOrderTracking_Sheet({
//   customContext,
//   required Order order,
// }) {
//   showModalBottomSheet(
//       enableDrag: true,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(40),
//           topLeft: Radius.circular(40),
//         ),
//       ),
//       context: customContext,
//       builder: (context) => BlocProvider<OrdersBloc>.value(
//             value: BlocProvider.of<OrdersBloc>(context),
//             child: Theme(
//               data: Theme.of(context)
//                   .copyWith(dividerColor: Colors.grey.shade100),
//               child: OrderInfoBottomSheet(
//                 blocContext: customContext,
//                 order: order,
//               ),
//             ),
//           )).then((value) => {});
// }

class OrderTrackingBottomSheet extends StatefulWidget {
  const OrderTrackingBottomSheet({
    Key? key,
    required this.order,
    required this.blocContext,
  }) : super(key: key);
  final Order order;
  final BuildContext blocContext;

  @override
  State<OrderTrackingBottomSheet> createState() =>
      _OrderTrackingBottomSheetState();
}

class _OrderTrackingBottomSheetState extends State<OrderTrackingBottomSheet> {
  bool isinit = false;

  @override
  void didChangeDependencies() {
    if (isinit) {}
    super.didChangeDependencies();
  }

  _buildLinearProgress(int current, int index) {
    return current < index
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: MediaQuery.of(context).size.width * .22.w,
              height: 6,
              child: const CustomProgressIndicator(
                color: Colors.grey,
                backgroundColor: Colors.grey,
              ),
            ),
          )
        : current > index
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    width: MediaQuery.of(context).size.width * .22.w,
                    height: 6,
                    child: const CustomProgressIndicator(
                      color: CustomColors.mainOrange,
                      backgroundColor: CustomColors.mainOrange,
                    )))
            : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    width: MediaQuery.of(context).size.width * .22.w,
                    height: 6,
                    child: const CustomProgressIndicator(
                      color: CustomColors.mainOrange,
                      backgroundColor: Color(0xFFFFDAB8),
                    )));
  }

  static int current = 0;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 20)).then((value) {
      current == 3
          ? Future.delayed(const Duration(seconds: 4)).then((value) {
              widget.order.state = 4;
              // Navigator.of(context).pop();
            })
          : {};

      if (current < 4) {
        current += 1;
        setState(() {});
      }
    });
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: Sizes.initialChildSize,
      builder: (context, scrollcontroller) => Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: scrollcontroller,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.paddingSize22,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Order tracking',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.fontSize16,
                            fontWeight: FontW.semiBold),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      endIndent: 80,
                      indent: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          current == 0
                              ? 'Order placed'
                              : current == 1
                                  ? 'Order accepted'
                                  : current == 2
                                      ? 'Prepared'
                                      : current == 3
                                          ? 'Delivering'
                                          : 'Delivered',
                          style: const TextStyle(
                              fontSize: Sizes.fontSize16,
                              fontWeight: FontWeight.w700),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLinearProgress(current, 0),
                        const SizedBox(
                          width: 4,
                        ),
                        _buildLinearProgress(current, 1),
                        const SizedBox(
                          width: 4,
                        ),
                        _buildLinearProgress(current, 2),
                        const SizedBox(
                          width: 4,
                        ),
                        _buildLinearProgress(current, 3),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    current > 0
                        ? Row(
                            children: [
                              const Text(
                                'Order will be ready in 50 mins.',
                                style: TextStyle(
                                    color: CustomColors.lightSubTextColor,
                                    fontSize: Sizes.fontSize14,
                                    fontWeight: FontW.light),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${widget.order.itemsList.length} item for ${widget.order.net.toStringAsFixed(2)}LE.',
                              style: const TextStyle(
                                  fontSize: Sizes.fontSize16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Delivery address: ${widget.order.delAddress}.',
                                  style: const TextStyle(
                                      color: CustomColors.lightSubTextColor,
                                      fontSize: Sizes.fontSize14,
                                      fontWeight: FontW.light),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: widget.order.itemsList.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                    '${widget.order.itemsList[index].mealImage}'),
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.order.itemsList[index].title}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizes.fontSize14,
                                    fontWeight: FontW.light),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${widget.order.itemsList[index].sizeName}',
                                style: const TextStyle(
                                    color: CustomColors.lightSubTextColor,
                                    fontSize: Sizes.fontSize14,
                                    fontWeight: FontW.light),
                              ),
                            ],
                          ),
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );

    //);
    // );
  }
}
