import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/model/response/products_response_model.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../pages/edit_product_page.dart';
import 'delete_product_dialog.dart';
// import '../../customer/dialogs/delete_product_dialog.dart';
// import '../pages/edit_product_page.dart';

class ProductCard extends StatelessWidget {
  final Products item;

  const ProductCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: "${Variables.BaseUrlApp}/storage/${item.image}",
            width: 120.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SpaceWidth(16.0),
                SizedBox(
                  width: 220.0,
                  child: Text(
                    item.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            Row(
              children: [
                const SpaceWidth(16.0),
                Text(
                  " Stok : ${item.stock.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Color.fromARGB(255, 146, 146, 146),
                  ),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            Row(
              children: [
                const SpaceWidth(16.0),
                Text(
                  item.price!.currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => context.push(EditProductPage(item: item)),
                  icon: Assets.icons.edit.svg(),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteProductDialog(
                        id: item.id!,
                      ),
                    );
                  },
                  icon: Assets.icons.delete.svg(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
