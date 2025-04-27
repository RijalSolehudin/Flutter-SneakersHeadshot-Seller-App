import 'package:ecommerce_seller_app/core/core.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/components.dart';
import '../bloc/get_history_order/get_history_order_bloc.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  void initState() {
    context
        .read<GetHistoryOrderBloc>()
        .add(const GetHistoryOrderEvent.getHistoryOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GetHistoryOrderBloc>()
              .add(const GetHistoryOrderEvent.getHistoryOrder());
        },
        child: BlocBuilder<GetHistoryOrderBloc, GetHistoryOrderState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loaded: (data) {
                final dataSorted = List.from(data);
                dataSorted.sort(
                  (a, b) => b.createdAt!.compareTo(a.createdAt!),
                );
                if (data.isEmpty) {
                  return const Center(
                    child: Text("Nothing here"),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const SpaceHeight(12.0),
                  itemBuilder: (context, index) => OrderCard(
                    item: dataSorted[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
