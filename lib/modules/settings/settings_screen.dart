import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';


class SettingsScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          fallback: (context) => const Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    const LinearProgressIndicator(),
                    const SizedBox(height: 20),
                  defaultTextFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter the name';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter the email address';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      textInputAction: TextInputAction.done,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter the phone';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        cubit.getUserUpdateData(
                          email: emailController.text,
                          phone: phoneController.text,
                          name: nameController.text,
                        );
                      }
                    },
                    text: 'update'.toUpperCase(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'logout'.toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
