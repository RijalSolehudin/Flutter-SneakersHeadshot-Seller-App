import 'package:ecommerce_seller_app/data/model/request/register_request_model.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/get_city/get_city_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/get_province/get_province_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/get_subdistrict/get_subdistrict_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';
import '../../../data/model/response/city_response_model.dart';
import '../../../data/model/response/province_response_model.dart';
import '../../../data/model/response/subdistrict_response_model.dart';
import '../bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dummy = ['Indonesia', 'Dummy 2', 'Dummy 3'];
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ValueNotifier countryNotifier;
  late final ValueNotifier provinceNotifier;
  late final ValueNotifier cityNotifier;
  late final ValueNotifier subdistrictNotifier;
  late final TextEditingController addressController;
  late final TextEditingController zipCodeController;
  late final TextEditingController phoneNumberController;
  XFile? image;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    countryNotifier = ValueNotifier(dummy.first);
    provinceNotifier = ValueNotifier(dummy.first);
    cityNotifier = ValueNotifier(dummy.first);
    subdistrictNotifier = ValueNotifier(dummy.first);
    addressController = TextEditingController();
    zipCodeController = TextEditingController();
    phoneNumberController = TextEditingController();
    context.read<GetProvinceBloc>().add(const GetProvinceEvent.GetProvince());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryNotifier.dispose();
    provinceNotifier.dispose();
    cityNotifier.dispose();
    subdistrictNotifier.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(18.0),
          const Center(
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: nameController,
            label: 'Nama Toko',
            hintText: 'Masukkan nama toko',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: emailController,
            label: 'E-mail',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            helperText: 'must contain 8 char.',
            obscureText: true,
            hintText: '*********',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(12.0),
          ValueListenableBuilder(
            valueListenable: countryNotifier,
            builder: (context, value, _) => CustomDropdown(
              value: value,
              items: dummy,
              label: 'Negara / Wilayah',
              onChanged: (value) => countryNotifier.value = value!,
            ),
          ),
          BlocBuilder<GetProvinceBloc, GetProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Text("Loading");
                },
                loaded: (results) {
                  return CustomDropdown<Province>(
                      value: results.first,
                      items: results,
                      label: 'Provinsi',
                      onChanged: (value) {
                        provinceNotifier.value = value!.provinceId;
                        context.read<GetCityBloc>().add(
                            GetCityEvent.getCity(int.parse(value.provinceId!)));
                      });
                },
              );
            },
          ),
          const SpaceHeight(12.0),
          BlocBuilder<GetCityBloc, GetCityState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () {
                    return const Text("Loading");
                  },
                  loaded: (result) => CustomDropdown<City>(
                        value: result.first,
                        items: result,
                        label: 'Kota',
                        onChanged: (value) {
                          cityNotifier.value = value!.cityId;
                          context.read<GetSubdistrictBloc>().add(
                              GetSubdistrictEvent.getSubdistrict(
                                  int.parse(value.cityId!)));
                        },
                      ));
            },
          ),
          const SpaceHeight(12.0),
          BlocBuilder<GetSubdistrictBloc, GetSubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () {
                    return const Text('loading');
                  },
                  loaded: (kecamatan) => CustomDropdown<Subdistrict>(
                      value: kecamatan.first,
                      items: kecamatan,
                      label: 'Kecamatan',
                      onChanged: (value) {
                        subdistrictNotifier.value = value!.subdistrictId;
                      }));
            },
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: addressController,
            label: 'Alamat',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            hintText: 'Masukkan kode POS',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: phoneNumberController,
            label: 'No Handphone',
            keyboardType: TextInputType.number,
            hintText: 'Masukkan nomor handphone',
          ),
          const SpaceHeight(12.0),
          CustomImagePicker(
            label: 'Foto Toko',
            onChanged: (imagePath) {
              image = imagePath;
            },
          ),

          // Tombol Register
          const SpaceHeight(38.0),
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: () {
                  Navigator.pop(context);
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.red,
                  ));
                },
              );
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        final data = RegisterRequestModel(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneNumberController.text,
                            address: addressController.text,
                            country: countryNotifier.value.toString(),
                            province: provinceNotifier.value.toString(),
                            city: cityNotifier.value.toString(),
                            district: subdistrictNotifier.value.toString(),
                            postalCode: zipCodeController.text,
                            image: image!);
                        context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.register(data));
                      },
                      label: 'Create Account',
                      borderRadius: 99.0,
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            ),
          ),
          const SpaceHeight(16.0),
          InkWell(
            onTap: () => context.pop(),
            child: const SizedBox(
              height: 50.0,
              child: Center(
                child: Text('already have an account? please login'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
