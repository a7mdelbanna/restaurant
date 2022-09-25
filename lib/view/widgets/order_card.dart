import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant/view/widgets/dragable_bottom_sheet.dart';

import '../../config/const.dart';
import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../../controller/bloc/blocs/orders/orders_bloc.dart';
import '../../data/model/order_model.dart';
import 'dialog.dart';
import 'order_tracking_sheet.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key, required this.order, required this.index})
      : super(key: key);
  final Order order;
  final int index;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late Future deleteItem;
  late bool canEdit;
  Widget _buildPanelHeader(context2) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: Sizes.paddingSize10,
              right: Sizes.paddingSize10,
              top: Sizes.paddingSize5,
              bottom: Sizes.paddingSize10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Code:',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    width: Sizes.size8,
                  ),
                  Text(
                    widget.order.id,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    TextVar.totalTextVar,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    width: Sizes.size8,
                  ),
                  SizedBox(
                    width: 120,
                    child: Chip(
                      label: Center(
                        child: Text(
                          '${widget.order.total.toStringAsFixed(2)}LE',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: Center(
                      child: Text(
                        DateFormat('hh:mm:ss   dd/MM/yyyy')
                            .format(widget.order.dateTime),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartEmptyState || state is CartLoadedState) {
                  return Row(
                    children: [
                      widget.order.state == 4
                          ? IconButton(
                              onPressed: () {
                                showmodelBottom_Sheet(
                                  customContext: context,
                                  order: widget.order,
                                );
                              },
                              icon: const Icon(
                                Icons.info,
                              ))
                          : IconButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) =>
                                        BlocProvider<OrdersBloc>.value(
                                          value: BlocProvider.of<OrdersBloc>(
                                              context),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.grey.shade100),
                                            child: OrderTrackingBottomSheet(
                                              blocContext: context,
                                              order: widget.order,
                                            ),
                                          ),
                                        )).then((value) => {
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            true, // set to false if you want to force a rating
                                        builder: (context) => DelRatingDialog(),
                                      ).then((value) => {
                                            setState(() {}),
                                          }),
                                    });
                              },
                              icon: const Icon(
                                Icons.delivery_dining,
                              )),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTitleItemsList() {
    return Column(
      children: List.generate(
        widget.order.itemsList.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.paddingSize4,
            horizontal: Sizes.paddingSize10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.order.itemsList[index].title.length > 25
                        ? widget.order.itemsList[index].title
                            .substring(0, 25)
                            .replaceRange(24, 25, '')
                        : widget.order.itemsList[index].title,
                    style: Theme.of(context).textTheme.bodyText1,
                    softWrap: true,
                  ),
                  const Spacer(),
                  Text('x${widget.order.itemsList[index].quantity}',
                      style: Theme.of(context).textTheme.bodyText1),
                  const Spacer(),
                  Text(
                    '${widget.order.itemsList[index].itemTotal}EGP',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          return Card(
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.all(Sizes.paddingSize8),
                child: ScrollOnExpand(
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                        animationDuration:
                            AnimationDuration.microAnimationDuration200,
                        scrollAnimationDuration:
                            AnimationDuration.microAnimationDuration200,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToExpand: true),
                    header: _buildPanelHeader(context),
                    expanded: _buildTitleItemsList(),
                    collapsed: Container(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// Column(
//       children: [
//         Card(
//           elevation:
//               widget.order.del ? 0 : Theme.of(context).cardTheme.elevation,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//             child: Row(
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       ' الإجمالى:',
//                       style: Theme.of(context).textTheme.headline3,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       DateFormat('dd/mm/yyyy  hh:mm')
//                           .format(widget.order.dateTime),
//                       style: const TextStyle(fontSize: 10, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                         child: Text(
//                           '${widget.order.total}',
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 10),
//                         ),
//                         backgroundColor: Colors.deepPurple),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _expanded[widget.index] = !_expanded[widget.index];
//                             print(_expanded[widget.index]);
//                             print('${widget.index}');
//                           });
//                         },
//                         icon: _expanded[widget.index]
//                             ? const Icon(
//                                 Icons.expand_less_outlined,
//                                 color: Colors.deepPurple,
//                               )
//                             : const Icon(
//                                 Icons.expand_more_outlined,
//                                 color: Colors.deepPurple,
//                               )),
//                     widget.order.del
//                         ? SizedBox(
//                             width: 0,
//                           )
//                         : IconButton(
//                             onPressed: () {}, icon: const Icon(Icons.delete)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         _expanded[widget.index]
//             ? Container(
//                 color: Theme.of(context).cardColor,
//                 child: Column(
//                   children: List.generate(
//                     widget.order.itemsList.length,
//                     (index) => Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(widget.order.itemsList[index].title,
//                                   style: Theme.of(context).textTheme.bodyText1),
//                               Text(
//                                   widget.order.itemsList[index].quantity
//                                           .toString() +
//                                       'x',
//                                   style: Theme.of(context).textTheme.bodyText1),
//                               Text(
//                                 widget.order.itemsList[index].price.toString() +
//                                     'EGP',
//                                 style: Theme.of(context).textTheme.bodyText1,
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             indent: 20,
//                             endIndent: 20,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : const SizedBox(
//                 height: 0,
//               ),
//       ],
//     );
//ExpansionTile(
//               iconColor: Theme.of(context).primaryColor,
//               childrenPadding:
//                   const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//               backgroundColor: Theme.of(context).cardColor,
//               title: _buildTileTitle(),
//               tilePadding: const EdgeInsets.symmetric(
//                   horizontal: Sizes.paddingSize14,
//                   vertical: Sizes.paddingSize8),
//               children: _buildTitleItemsList(),
//             )
