import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/social_app/social_layout.dart';
import 'package:flutter_project/modules/social_app/social_register/cubit/register_cubit.dart';
import 'package:flutter_project/modules/social_app/social_register/cubit/register_states.dart';

import '../../../shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateFinish(context, SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Register',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformfield(
                            textEditingController: nameController,
                            textInputType: TextInputType.text,
                            label: 'User Name',
                            perfix: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'User name must not be Empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformfield(
                            textEditingController: emailController,
                            textInputType: TextInputType.emailAddress,
                            label: 'Email Address',
                            perfix: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be Empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformfield(
                            textEditingController: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            label: 'Password',
                            ispassword:
                                SocialRegisterCubit.get(context).isPassword,
                            perfix: Icons.lock_outline,
                            suffixpressed: () {
                              SocialRegisterCubit.get(context).changePassword();
                            },
                            suffix: SocialRegisterCubit.get(context).suffix,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be Empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformfield(
                            textEditingController: phoneController,
                            textInputType: TextInputType.phone,
                            label: 'Phone',
                            perfix: Icons.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone must not be Empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultbutton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'Register'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
