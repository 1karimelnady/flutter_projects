import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/social_app/social_layout.dart';
import 'package:flutter_project/modules/social_app/social_login/cubit/cubit.dart';
import 'package:flutter_project/modules/social_app/social_login/cubit/states.dart';
import 'package:flutter_project/modules/social_app/social_register/social_register_screen.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
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
                        Text('Login',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
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
                                SocialLoginCubit.get(context).ispassword,
                            perfix: Icons.lock_outline,
                            suffixpressed: () {
                              SocialLoginCubit.get(context).changeVisibilty();
                            },
                            suffix: SocialLoginCubit.get(context).suffix,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be Empty';
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultbutton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'Login'),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            defalutTextButton(
                                text: 'Register',
                                function: () {
                                  navigateTo(context, SocialRegisterScreen());
                                })
                          ],
                        ),
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
