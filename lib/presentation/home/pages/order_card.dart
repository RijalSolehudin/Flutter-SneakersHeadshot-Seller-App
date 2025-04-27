import 'package:ecommerce_seller_app/data/model/response/history_order_response_model.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../pages/order_detail_page.dart';

class OrderCard extends StatelessWidget {
  final HistoryOrder item;
  const OrderCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 8.0,
            spreadRadius: 0,
            color: AppColors.primary.withOpacity(0.16),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.user!.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: ColoredBox(
                  color: (item.status == "PENDING")
                      ? const Color.fromARGB(255, 255, 51, 0)
                      : AppColors.primary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      item.status!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SpaceHeight(24.0),
          Text(
            'Produk : ${item.orderItems!.map(
              (e) => e.product!.name,
            )}',
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 12.0,
            ),
          ),
          Text(
            'Jumlah Total : ${item.grandTotal!.currencyFormatRp}',
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 12.0,
            ),
          ),
          const Divider(),
          Row(
            children: [
              Text(
                'Kode Pesanan : ${item.transactionNumber}',
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Metode Pembayaran : ${item.paymentVaName!.toUpperCase()}',
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 12.0,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push(OrderDetailPage(
                  historyOrder: item,
                )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: const ColoredBox(
                    color: Color.fromARGB(255, 30, 140, 224),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Detail Pesanan",
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
