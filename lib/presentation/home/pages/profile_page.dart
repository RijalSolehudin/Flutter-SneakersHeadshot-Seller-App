// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_seller_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:ecommerce_seller_app/presentation/auth/pages/login_page.dart';

import '../../../core/constants/variables.dart';
import '../../../core/core.dart';
import '../../../data/model/response/login_response_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  Future<void> _loadData() async {
    LoginResponseModel? userData = await AuthLocalDatasource().getLoginData();
    setState(() {
      user = userData.data!.user;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _loadData();
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      stops: [
                        -0.3,
                        0,
                        0.8
                      ],
                      colors: [
                        AppColors.primary,
                        AppColors.white,
                        AppColors.primary
                      ])),
              child: user == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SpaceHeight(20),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: const Color.fromARGB(
                                        255, 237, 255, 185),
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${Variables.BaseUrlApp}/storage/${user?.photo ?? ''}",
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ),
                            ),
                            SpaceWidth(20),
                            Text(
                              user?.name ?? 'Nama Tidak Tersedia',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30),
                            )
                          ],
                        ),
                      ],
                    ),
            ),
            const SpaceHeight(16.0),
            ListTile(
              title: Text(
                user?.email ?? 'Email tidak Tersedia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              subtitle: Text('Kota ${user?.city ?? ''}'),
            ),
            const SpaceHeight(8.0),
            ListTile(
              onTap: () {},
              // onTap: () => context.push(const ProfileDetailPage()),
              title: const Text(
                'Informasi Akun',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Informasi akun milikmu'),
              trailing: const Icon(Icons.chevron_right),
            ),
            BlocListener<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  },
                  success: () {
                    context.pushReplacement(const LoginPage());
                  },
                );
              },
              child: ListTile(
                onTap: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                title: const Text(
                  'Keluar Akun',
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Keluar dari akun kamu'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
