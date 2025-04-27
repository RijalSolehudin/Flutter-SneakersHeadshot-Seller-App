import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/model/response/history_order_response_model.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'input_resi_page.dart';

class OrderDetailPage extends StatelessWidget {
  final HistoryOrder historyOrder;
  const OrderDetailPage({super.key, required this.historyOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => _ProductCard(
                      item: historyOrder.orderItems![index], onTap: () {}),
                  separatorBuilder: (context, index) => const SpaceHeight(12.0),
                  itemCount: historyOrder.orderItems!.length)),
          const SpaceWidth(24.0),
          const Divider(),
          const SpaceWidth(14.0),
          Row(
            children: [
              const Text(
                'Total Harga : ',
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
              Text(
                190000.currencyFormatRp,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push(InputResiPage(
                  orderId: historyOrder.id!,
                )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: const ColoredBox(
                    color: AppColors.primary,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Kirim',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final OrderItem item;
  final VoidCallback onTap;

  const _ProductCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: "${Variables.BaseUrlApp}/storage/${item.product!.image}",
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
        ),
        const SpaceWidth(16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.product!.name!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SpaceHeight(8.0),
            Text.rich(
              TextSpan(
                text: 'Harga : ',
                children: [
                  TextSpan(
                    text: item.product!.price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(4.0),
            Text('Kuantitas : ${item.quantity}'),
          ],
        ),
      ],
    );
  }
}
