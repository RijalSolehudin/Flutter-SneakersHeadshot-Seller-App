import 'package:ecommerce_seller_app/presentation/home/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../widget/product_card.dart';
import 'add_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    context
        .read<GetAllProductsBloc>()
        .add(const GetAllProductsEvent.getProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 10,
        title: const Text(
          'Product',
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddProductPage())),
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColors.white,
            ),
          ),
          const SpaceWidth(10.0),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GetAllProductsBloc>()
              .add(const GetAllProductsEvent.getProducts());
        },
        child: BlocBuilder<GetAllProductsBloc, GetAllProductsState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              success: (data) {
                if (data.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.alert.empty.image(height: 154.0),
                        const SpaceHeight(50.0),
                        const Text(
                          'Product belum tersedia',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SpaceHeight(16.0),
                        const Text(
                          'Anda tidak memiliki product di toko. Silakan tambahkan menu terlebih dahulu.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => ProductCard(
                    item: data[index],
                  ),
                );
              },
            );
          },
        ),
      ),

      //
      //
    );
  }
}
