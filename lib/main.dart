import 'package:ecommerce_seller_app/data/datasources/agora_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/datasources/category_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/datasources/firebase_messaging_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/datasources/order_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:ecommerce_seller_app/firebase_options.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/get_city/get_city_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/get_province/get_province_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/get_subdistrict/get_subdistrict_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/EDIT_Product/edit_product_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/add_category/add_category_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/delete_product/delete_product_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_agora_token/get_agora_token_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_all_products/get_all_products_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_categories/get_categories_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/get_history_order/get_history_order_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/set_livestreaming/set_livestreaming_bloc.dart';
import 'package:ecommerce_seller_app/presentation/home/bloc/update_resi/update_resi_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'presentation/auth/pages/splash_page.dart';
import 'presentation/home/bloc/add_product/add_product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessangingRemoteDatasource().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetProvinceBloc>(
          create: (context) => GetProvinceBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider<GetCityBloc>(
          create: (context) => GetCityBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider<GetSubdistrictBloc>(
          create: (context) => GetSubdistrictBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(create: (context) => GetAllProductsBloc()),
        BlocProvider(
          create: (context) => AddProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeleteProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => EditProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetCategoriesBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddCategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SetLivestreamingBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetAgoraTokenBloc(AgoraRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetHistoryOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateResiBloc(OrderRemoteDatasource()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Intensive Club batch 19',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          scaffoldBackgroundColor: AppColors.white,
          dialogBackgroundColor: AppColors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.white,
          ),
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: AppColors.white),
          dividerTheme: const DividerThemeData(color: AppColors.stroke),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.inter(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
