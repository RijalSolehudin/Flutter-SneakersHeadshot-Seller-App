import 'package:ecommerce_seller_app/core/constants/variables.dart';
import 'package:ecommerce_seller_app/data/model/request/edit_product_request_model.dart';
import 'package:ecommerce_seller_app/data/model/response/products_response_model.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/EDIT_Product/edit_product_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/components.dart';

class EditProductPage extends StatefulWidget {
  final Products item;
  const EditProductPage({super.key, required this.item});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController stockController;
  XFile? image;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.item.name);
    descriptionController =
        TextEditingController(text: widget.item.description);
    priceController = TextEditingController(text: '${widget.item.price}');
    stockController = TextEditingController(text: '${widget.item.stock}');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Nama Product',
            hintText: 'Masukkan nama product',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(8.0),
          CustomTextField(
            controller: descriptionController,
            label: 'Deskripsi',
            hintText: 'Masukkan Deskripsi',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(8.0),
          CustomImagePicker(
            label: 'Gambar',
            imageUrl: "${Variables.BaseUrlApp}/storage/${widget.item.image}",
            onChanged: (imagePath) {
              if (imagePath != null) {
                image = imagePath;
              }
            },
          ),
          const SpaceHeight(8.0),
          CustomTextField(
            controller: priceController,
            label: 'Harga',
            hintText: 'Masukkan Harga',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(8.0),
          CustomTextField(
            controller: stockController,
            label: 'Total Stok',
            hintText: 'Masukkan jumlah ketersediaan',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<EditProductBloc, EditProductState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                Navigator.pop(context);
                context
                    .read<GetAllProductsBloc>()
                    .add(const GetAllProductsEvent.getProducts());
              },
              error: (message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  onPressed: () {
                    final data = EditProductRequestModel(
                        name: nameController.text,
                        id: widget.item.id!,
                        categoryId: widget.item.categoryId!,
                        description: descriptionController.text,
                        price: int.parse(
                            priceController.text.replaceAll('.00', '')),
                        stock: int.parse(stockController.text),
                        image: image);
                    context
                        .read<EditProductBloc>()
                        .add(EditProductEvent.editProduct(data));
                  },
                  label: 'Tambah',
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
