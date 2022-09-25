import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/controller/bloc/blocs/orders/orders_bloc.dart';
import 'package:restaurant/controller/bloc/cubit/authintication/auth_cubit.dart';
import 'package:restaurant/view/widgets/dialog.dart';

import '../../config/const.dart';
import '../../controller/bloc/blocs/cart/cart_bloc.dart';
import '../../data/model/order_model.dart';

showOrderBottom_Sheet({
  customContext,
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
              child: OrderTrackingBottomSheet(
                blocContext: context,
              ),
            ),
          ));
}

class OrderTrackingBottomSheet extends StatefulWidget {
  OrderTrackingBottomSheet({
    Key? key,
    // required this.order,
    required this.blocContext,
  }) : super(key: key);
  final Order order = Order(
      state: 0,
      firstName: 'firstName',
      userId: 'userId',
      del: false,
      id: 'id',
      total: 20.0,
      itemsList: [],
      dateTime: DateTime.now(),
      phone: '',
      net: 203,
      totalTax: 3,
      totalOfferDis: 2,
      ser: 1,
      no: 2,
      delAddress: 'delAddress');
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

  final TextEditingController _cardNumberController = TextEditingController();

  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();

  final TextEditingController _cardHolderController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool backVisible = false;
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
                          'Payment',
                          style: TextStyle(
                              fontSize: Sizes.fontSize21,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.black54,
                      indent: 90,
                      endIndent: 90,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Order Total:',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '${widget.order.total.toStringAsFixed(2)}LE',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        CreditCardWidget(
                          cardNumber: '',
                          expiryDate: '',
                          cardHolderName: '',
                          cvvCode: '',
                          showBackView: false,
                          onCreditCardWidgetChange:
                              (CreditCardBrand) {}, //true when you want to show cvv(back) view
                        ),
                        CreditCardForm(
                          cardHolderName: '', cardNumber: '', cvvCode: '',
                          expiryDate: '',

                          formKey: formKey, // Required
                          onCreditCardModelChange: (CreditCardModel data) {
                            print(data.cvvCode);
                            backVisible = data.cvvCode.isEmpty ? false : true;
                          }, // Required
                          themeColor: Colors.red,
                          obscureCvv: true,
                          obscureNumber: true,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardNumberDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Holder',
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context1, state) {
                          if (state is CartLoadingState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: CustomColors.mainOrange,
                                  minimumSize: const Size(300, 40)),
                              onPressed: () {},
                              child: const CircularProgressIndicator(),
                            );
                          } else if (state is CartLoadedState) {
                            {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: CustomColors.mainOrange,
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
                                    primary: CustomColors.mainOrange,
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
                                  primary: CustomColors.mainOrange,
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
