import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../layout/shopLayout.dart';
import '../../network/local/cache_helper.dart';
import '../login/shop_login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class ShopRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterCubitStates>(
          listener: (BuildContext context, state) {

            if (state is ShopRegisterCubitSuccessState) {
              if (state.loginModel.status!) {
                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token!;
                  navigateAndFinish(context, const ShopLayout());
                });
              } else {
                showToast(
                    message: state.loginModel.message!,
                    states: ToastStates.ERROR);
              }
            }
          },
          builder: (BuildContext context, Object? state) {
            var cubit = ShopRegisterCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            label: "User Name",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your User Name';
                              } else {
                                return null;
                              }
                            },
                            prefix: Icons.person),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            label: "Email",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your email address';
                              } else {
                                return null;
                              }
                            },
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            label: "Phone",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your Phone';
                              } else {
                                return null;
                              }
                            },
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: passController,
                            onPressSuffix: () {
                              cubit.changePasswordVisibility();
                            },
                            textInputType: TextInputType.visiblePassword,
                            label: "Password",
                            obscure: cubit.isPasswordShown,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit
                                  .userRegister(
                                    email: emailController.text,
                                    password: passController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                              }
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              } else {
                                return null;
                              }
                            },
                            prefix: Icons.lock_outline,
                            suffixIcon: cubit.suffix),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopRegisterCubitLoadingState,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('have an account ?'),
                            defaultTextButton(
                                onPress: () {
                                  navigateTo(context, ShopLoginScreen());
                                },
                                text: 'Login Here')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
