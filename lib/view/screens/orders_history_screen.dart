import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/view/widgets/order_tracking_bottom_sheet.dart';

import '../../config/const.dart';
import '../../controller/bloc/blocs/orders/orders_bloc.dart';
import '../../data/model/order_model.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/webservices/order_web_services.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/order_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const orderScreenRoute = '/order_screen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderRepository orderRepository;

  @override
  initState() {
    orderRepository = OrderRepository(OrderWebServices());
    super.initState();
  }

  Widget _buildAppBar() {
    return CustomAppBar(
        context: context,
        expandedHeight: kToolbarHeight,
        collapsedHeight: kToolbarHeight,
        customTitle: Text(TextVar.orderText,
            style: Theme.of(context).textTheme.headline2));
  }

  Widget _buildOrdersList(List<Order> orders) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          orders.length,
          (index) => OrderCard(order: orders[index], index: index),
        ),
      ),
    );
  }

  _buildBlocWidget(context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
        if (state is OrdersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OrdersEmptyState) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Image(
                fit: BoxFit.cover,
                height: 200,
                width: 250,
                image: const AssetImage('assets/images/emptyHistory.jpg'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('You haven\'t made your first order yet.',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Make your first order now.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey)),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 40),
                ),
                onPressed: () {
                  showOrderBottom_Sheet(
                    customContext: context,
                  );
                },
                child: const Text(
                  'Menu',
                ),
              ),
            ),
          ]);
        } else if (state is OrdersLoadedState) {
          return _buildOrdersList(state.orders.orders.toList());
        } else if (state is OrdersErrorState) {
          return const Text('Error');
        } else {
          return const Text('Error');
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildBlocWidget(context),
        ],
      ),
    );
  }
}
