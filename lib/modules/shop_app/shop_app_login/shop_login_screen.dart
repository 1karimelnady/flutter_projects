import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/shop_app/shop_app_login/cubit/cubit.dart';
import 'package:flutter_project/modules/shop_app/shop_app_login/cubit/states.dart';
import 'package:flutter_project/shared/components/components.dart';

import '../register_screen/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({super.key});
  var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){},
        builder: (context,state){
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
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          'Login now to browse our hot offers ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30,),
                        defaultformfield(
                            textEditingController: emailController,
                            textInputType: TextInputType.emailAddress,
                            perfix: Icons.email_outlined,
                            label: 'Email Address',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Email must not be empty';
                              }
                            }
                        ),
                        const SizedBox(height: 20,),

                        defaultformfield(
                            textEditingController: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            label: 'Password ',
                            ispassword:ShopLoginCubit.get(context).ispassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixpressed: (){
                              ShopLoginCubit.get(context).changeVisibilty();
                            },
                            perfix: Icons.lock_outline,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Password is too short';
                              }
                            }
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context)=>defaultbutton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                } else {
                                  print('error');
                                }

                              },
                              text: 'LOGIN',
                              background: Colors.blue
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            defalutTextButton(text: 'Register', function: (){
                              navigateFinish(context, RegisterScreen());
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
