import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/controller/bloc/blocs/orders/orders_bloc.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';
import 'package:restaurant/view/widgets/dialog.dart';

import '../../config/const.dart';
import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../../data/model/order_model.dart';

showmodelBottom_Sheet({
  customContext,
  required Order order,
}) {
  showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      context: customContext,
      builder: (context) => BlocProvider<OrdersBloc>.value(
            value: BlocProvider.of<OrdersBloc>(context),
            child: Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: Colors.grey.shade100),
              child: OrderInfoBottomSheet(
                blocContext: customContext,
                order: order,
              ),
            ),
          ));
}

class OrderInfoBottomSheet extends StatefulWidget {
  const OrderInfoBottomSheet({
    Key? key,
    required this.order,
    required this.blocContext,
  }) : super(key: key);
  final Order order;
  final BuildContext blocContext;

  @override
  State<OrderInfoBottomSheet> createState() => _OrderInfoBottomSheetState();
}

class _OrderInfoBottomSheetState extends State<OrderInfoBottomSheet> {
  bool isinit = false;

  @override
  void didChangeDependencies() {
    if (isinit) {}
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: Sizes.initialChildSize,
      builder: (context, scrollcontroller) => Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: scrollcontroller,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.paddingSize12,
              vertical: Sizes.paddingSize22,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Order Info',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.fontSize16,
                              fontWeight: FontW.semiBold),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      indent: 80,
                      endIndent: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Code:',
                          style: TextStyle(
                              fontSize: Sizes.fontSize18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(widget.order.id,
                            style: const TextStyle(
                                fontSize: Sizes.fontSize16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: Sizes.fontSize18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('${widget.order.total.toStringAsFixed(2)}LE',
                            style: const TextStyle(
                                fontSize: Sizes.fontSize16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Del:',
                          style: TextStyle(
                              fontSize: Sizes.fontSize18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text('${widget.order.totalTax.toStringAsFixed(2)}LE',
                            style: const TextStyle(
                                fontSize: Sizes.fontSize16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Net:',
                          style: TextStyle(
                              fontSize: Sizes.fontSize18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text('${widget.order.net.toStringAsFixed(2)}LE',
                            style: const TextStyle(
                                fontSize: Sizes.fontSize16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Delivered To:',
                          style: TextStyle(
                              fontSize: Sizes.fontSize18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(widget.order.id,
                              style: const TextStyle(
                                  fontSize: Sizes.fontSize14,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(color: Colors.grey.shade300),
                    Column(
                      children: List.generate(widget.order.itemsList.length,
                          (index1) {
                        return ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          iconColor: Colors.black,
                          leading: Image(
                              width: 40,
                              height: 30,
                              image: AssetImage(
                                  widget.order.itemsList[index1].mealImage)),
                          tilePadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.order.itemsList[index1].title.length >
                                          25
                                      ? widget.order.itemsList[index1].title
                                          .substring(0, 25)
                                          .replaceRange(24, 25, '')
                                      : widget.order.itemsList[index1].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox.shrink(),
                              Text(
                                  'x${widget.order.itemsList[index1].quantity}',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 45,
                                ),
                                const Icon(
                                  Icons.add,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Wrap(
                                  children: List.generate(
                                    widget.order.itemsList[index1].addedToppings
                                        .length,
                                    (index) => Text(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      '${widget.order.itemsList[index1].addedToppings[index].toppingTitle}, ',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                const SizedBox(
                                  width: 45,
                                ),
                                const Icon(
                                  Icons.remove,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Wrap(
                                  children: List.generate(
                                    widget.order.itemsList[index1]
                                        .removedIngredients.length,
                                    (index) => Text(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      '${widget.order.itemsList[index1].removedIngredients[index]}, ',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context1, state) {
                          if (state is CartLoadingState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: CustomColors.lightActiveButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.radius15),
                                  ),
                                  elevation: Sizes.buttonElevation4,
                                  minimumSize: const Size(300, 40)),
                              onPressed: () {},
                              child: const CircularProgressIndicator(),
                            );
                          } else if (state is CartLoadedState) {
                            {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          CustomColors.lightActiveButtonColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Sizes.radius15),
                                      ),
                                      elevation: Sizes.buttonElevation4,
                                      minimumSize: const Size(300, 40)),
                                  onPressed: () async {
                                    final res = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DeleteDialog(
                                            context: context,
                                            dialogTitle: 'CART NOT EMPTY!',
                                            dialogContent:
                                                'Your cart is active, what do you want to do?',
                                            dialogIcon: Icons.warning_amber,
                                            dialogIconColor: Colors.blueGrey,
                                            acceptText: 'Delete items in cart',
                                            cancelText: 'Merge items');
                                      },
                                    );

                                    context.read<CartBloc>().add(
                                          AddMultiProductEvent(
                                              widget.order.itemsList,
                                              BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .getUserId(),
                                              res,
                                              false,
                                              true),
                                        );
                                  },
                                  child: const Text('Re-order'));
                            }
                          } else if (state is CartEmptyState) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        CustomColors.lightActiveButtonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(Sizes.radius15),
                                    ),
                                    elevation: Sizes.buttonElevation4,
                                    minimumSize: const Size(300, 40)),
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                      AddMultiProductEvent(
                                          widget.order.itemsList,
                                          BlocProvider.of<AuthCubit>(context)
                                              .getUserId(),
                                          true,
                                          true,
                                          true));
                                  Fluttertoast.showToast(
                                    msg: 'Order Copied to cart',
                                    toastLength: Toast.LENGTH_SHORT, // length
                                  );
                                },
                                child: const Text('Re-order'));
                          } else {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: CustomColors.lightActiveButtonColor,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.circular(Sizes.radius15),
                                  ),
                                  elevation: Sizes.buttonElevation4,
                                  minimumSize: const Size(300, 40)),
                              onPressed: () {},
                              child: const Text('error'),
                            );
                          }
                        },
                      ),
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
