import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/view/widgets/dialog.dart';

import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../../data/model/cart.dart';
import 'custom_icon_button.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({Key? key, required this.cartItem, required this.index})
      : super(key: key);
  final CartItem cartItem;
  final int index;
  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.cartItem.removedIngredients.length);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      onDismissed: (direction) {
        BlocProvider.of<CartBloc>(context)
            .add(RemoveProductEvent(widget.index, widget.cartItem, 'uid'));
      },
      background: Card(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return showDialog(
          context: context,
          builder: (context) => DeleteDialog(
            acceptText: 'Yes',
            cancelText: 'No',
            context: context,
            dialogContent: 'The item will be deleted from cart',
            dialogTitle: 'Deleting Item!',
            dialogIcon: Icons.delete,
            dialogIconColor: Colors.red,
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    radius: 45,
                    foregroundImage: AssetImage(widget.cartItem.mealImage),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                softWrap: true,
                                widget.cartItem.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.cartItem.sizeName,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('- ', style: TextStyle(color: Colors.grey)),
                            Expanded(
                              child: Wrap(
                                children: List.generate(
                                  widget.cartItem.removedIngredients.length,
                                  (index) => Text(
                                      widget.cartItem
                                              .removedIngredients[index] +
                                          ', ',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('+ ', style: TextStyle(color: Colors.grey)),
                            Expanded(
                              child: Wrap(
                                children: List.generate(
                                  widget.cartItem.addedToppings.length,
                                  (index) => Text(
                                    style: TextStyle(color: Colors.grey),
                                    widget.cartItem.addedToppings[index]
                                            .toppingTitle +
                                        ', ',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.edit,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              ),
              Divider(
                height: 5,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // + - items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RectangularIconButton(
                            icon: Icons.add,
                            onTap: () {
                              context
                                  .read<CartBloc>()
                                  .add(ChangeCartItemQuantity(
                                    widget.cartItem,
                                    true,
                                    widget.index,
                                  ));
                            },
                            size: 60,
                            iconColor: Colors.black,
                            backgroundColor: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.cartItem.quantity.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RectangularIconButton(
                          icon: Icons.remove,
                          onTap: () async {
                            if (widget.cartItem.quantity == 1) {
                              final res = await showDialog(
                                context: context,
                                builder: (context) => DeleteDialog(
                                    dialogIcon: Icons.delete,
                                    dialogIconColor: Colors.red,
                                    acceptText: 'Confirm',
                                    cancelText: 'cancel',
                                    context: context,
                                    dialogTitle: 'Deleting item?',
                                    dialogContent:
                                        'Item will be deleted from cart!'),
                              );
                              if (res == true) {
                                context
                                    .read<CartBloc>()
                                    .add(ChangeCartItemQuantity(
                                      widget.cartItem,
                                      false,
                                      widget.index,
                                    ));
                              } else {}
                            } else {
                              context
                                  .read<CartBloc>()
                                  .add(ChangeCartItemQuantity(
                                    widget.cartItem,
                                    false,
                                    widget.index,
                                  ));
                            }
                          },
                          size: 60,
                          iconColor: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                    Chip(
                      labelPadding: EdgeInsets.all(5),
                      label: SizedBox(
                        width: {widget.cartItem.itemTotal}.toString().length > 8
                            ? 120
                            : 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.cartItem.itemTotal.toString() + '0LE',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
