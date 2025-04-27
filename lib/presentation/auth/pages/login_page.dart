import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/presentation/auth/pages/register_page.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              transform: GradientRotation(-0.2),
              begin: AlignmentDirectional.topStart,
              end: Alignment.bottomLeft,
              stops: [
            0.45,
            0.75,
            1.2
          ],
              colors: [
            AppColors.primary,
            Color.fromARGB(255, 244, 114, 226),
            AppColors.blue
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 90),
              child: SizedBox(
                  child: Assets.images.sneakerheadshot.image(scale: 1.3)),
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.3), // Warna bayangan dengan transparansi
                      blurRadius: 10, // Semakin besar, semakin kabur
                      spreadRadius: 2, // Menentukan seberapa luas bayangan
                      offset: Offset(4, 4),
                    )
                  ],
                  color: const Color.fromARGB(135, 102, 96, 96),
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Column(
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SpaceHeight(20.0),
                  CustomTextField(
                    labelColor: AppColors.white,
                    controller: emailController,
                    label: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SpaceHeight(12.0),
                  CustomTextField(
                    labelColor: AppColors.white,
                    controller: passwordController,
                    label: 'Password',
                    obscureText: true,
                  ),
                  const SpaceHeight(12.0),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      // onTap: () => context.push(const ForgotPasswordPage()),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SpaceHeight(12.0),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: (data) async {
                          await AuthLocalDatasource().saveLoginData(data);
                          context.pushReplacement(const MainPage());
                        },
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Username atau Password salah")));
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<LoginBloc>().add(LoginEvent.login(
                                  email: emailController.text,
                                  password: passwordController.text));
                            },
                            label: 'Login',
                            borderRadius: 99.0,
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
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const InkWell(
                // onTap: () => context.push(const RegisterPage()),
                child: SizedBox(
                  height: 50.0,
                  child: Center(
                    child: Text(
                      'don\'t have an account yet? please register',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => context.push(const RegisterPage()),
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.white,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      'Daftarkan seller',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
