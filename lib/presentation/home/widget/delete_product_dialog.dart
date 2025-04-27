import 'package:ecommerce_seller_app/presentation/home/bloc/delete_product/delete_product_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

class DeleteProductDialog extends StatelessWidget {
  final int id;
  const DeleteProductDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hapus Produk?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
                color: Colors.grey,
              ),
            ],
          ),
          const Text(
            'Apakah anda yakin untuk menghapus produk ini ?',
            style: TextStyle(
              color: AppColors.gray,
            ),
          ),
          const SpaceHeight(40.0),
          Row(
            children: [
              Flexible(
                child: Button.outlined(
                  onPressed: () => context.pop(),
                  label: 'Cancel',
                  borderRadius: 8.0,
                  height: 44.0,
                  fontSize: 14.0,
                ),
              ),
              const SpaceWidth(10.0),
              Flexible(
                child: Button.filled(
                  onPressed: () {
                    context
                        .read<DeleteProductBloc>()
                        .add(DeleteProductEvent.deleteProduct(id));
                    context
                        .read<GetAllProductsBloc>()
                        .add(const GetAllProductsEvent.getProducts());
                    context.pop();
                  },
                  label: 'Confirm',
                  borderRadius: 8.0,
                  height: 44.0,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
