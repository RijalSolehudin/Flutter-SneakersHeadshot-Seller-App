import 'package:ecommerce_seller_app/data/model/request/add_product_request_model.dart';
import 'package:ecommerce_seller_app/data/model/response/categories_response_model.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/add_category/add_category_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_categories/get_categories_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/components.dart';
import '../bloc/add_product/add_product_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  XFile? image;
  int categoryId = 1;

  @override
  void initState() {
    context
        .read<GetCategoriesBloc>()
        .add(const GetCategoriesEvent.getCategories());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
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
          BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Text('loading');
                },
                loaded: (data) {
                  return CustomDropdown<Categories>(
                      value: data.first,
                      items: data,
                      label: 'Kategori',
                      onChanged: (value) {
                        categoryId = value!.id!;
                      });
                },
                error: (message) {
                  return Text(message);
                },
              );
            },
          ),
          const SpaceHeight(8.0),
          Button.filled(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Tambah Kategori'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            controller: categoryController,
                            label: "Nama Kategori",
                            hintText: 'Masukan nama kategori',
                          ),
                          const SpaceHeight(8.0)
                        ],
                      ),
                      actions: [
                        BlocConsumer<AddCategoryBloc, AddCategoryState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              success: () {
                                categoryController.clear();
                                context.read<GetCategoriesBloc>().add(
                                    const GetCategoriesEvent.getCategories());
                                Navigator.pop(context);
                              },
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Button.filled(
                                  onPressed: () {
                                    context.read<AddCategoryBloc>().add(
                                        AddCategoryEvent.addCategory(
                                            name: categoryController.text));
                                  },
                                  label: "OK",
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                        const SpaceHeight(8.0),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Batal"))
                      ],
                    );
                  },
                );
              },
              label: "Tambah Kategori"),
          const SpaceHeight(10.0),
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
        child: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                context
                    .read<GetAllProductsBloc>()
                    .add(const GetAllProductsEvent.getProducts());
                Navigator.pop(context);
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
                    final data = AddProductRequestModel(
                        categoryId: categoryId,
                        name: nameController.text,
                        description: descriptionController.text,
                        price: int.parse(priceController.text),
                        stock: int.parse(stockController.text),
                        image: image!);
                    context
                        .read<AddProductBloc>()
                        .add(AddProductEvent.addProduct(data));
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
