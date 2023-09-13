import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/shop_layout.dart';
import 'package:flutter_project/modules/shop_app/shop_app_login/cubit/cubit.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:flutter_project/shared/components/constants.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:flutter_project/modules/shop_app/register_screen/cubit/register_cubit.dart';
import 'package:flutter_project/modules/shop_app/register_screen/cubit/register_states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value) {
                token = state.loginModel.data!.token!;

                navigateFinish(
                  context,
                  const ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
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
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultformfield(
                          textInputType: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'User Name',
                          perfix: Icons.person,
                          textEditingController: nameController,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultformfield(
                          textInputType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'Email Address',
                          perfix: Icons.person,
                          textEditingController: emailController,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultformfield(
                            textEditingController: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            label: 'Password ',
                            ispassword:
                                ShopRegisterCubit.get(context).isPassword,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            suffixpressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            perfix: Icons.lock_outline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultformfield(
                          textInputType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                          },
                          label: 'Phone ',
                          perfix: Icons.phone,
                          textEditingController: phoneController,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultbutton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
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

  // ShopRegisterScreen({super.key});
  // var nameController = TextEditingController();
  // var phoneController = TextEditingController();
  // var emailController = TextEditingController();
  // var passwordController = TextEditingController();
  // var formKey = GlobalKey<FormState>();
  // @override
  // Widget build(BuildContext context) {
  //   return  BlocProvider(
  //     create: (BuildContext context)=>ShopRegisterCubit(),
  //     child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
  //       listener: (context,state){},
  //       builder: (context,state){
  //             return Scaffold(
  //               appBar: AppBar(),
  //               body: Center(
  //                 child: SingleChildScrollView(
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(20.0),
  //                     child: Form(
  //                       key: formKey,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'REGISTER',
  //                             style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontWeight: FontWeight.bold),
  //                           ),
  //                           const SizedBox(height: 15,),
  //                           Text(
  //                             'Register now to browse our hot offers ',
  //                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),
  //                           ),
  //                                             const SizedBox(height: 30,),
  //                                             defaultformfield(
  //                                                 textEditingController: nameController,
  //                                            textInputType: TextInputType.name,
  //                                                 perfix: Icons.person,
  //                                                 label: 'Name ',
  //                                                 validator: (value){
  //                                                   if(value!.isEmpty){
  //                                                     return 'Name must not be empty';
  //                                                   }
  //                                                 }
  //                                             ),
  //                                             const SizedBox(height: 30,),
  //                                             defaultformfield(
  //                                                 textEditingController: emailController,
  //                                                 textInputType: TextInputType.emailAddress,
  //                                                 perfix: Icons.email_outlined,
  //                                                 label: 'Email Address',
  //                                                 validator: (value){
  //                                                   if(value!.isEmpty){
  //                                                     return 'Email must not be empty';
  //                                                   }
  //                                                 }
  //                                             ),
  //                                             const SizedBox(height: 20,),
  //                                             defaultformfield(
  //                                                 textEditingController: passwordController,
  //                                                 textInputType: TextInputType.visiblePassword,
  //                                                 label: 'Password ',
  //                                                 ispassword:ShopLoginCubit.get(context).ispassword,
  //                                                 suffix: ShopLoginCubit.get(context).suffix,
  //                                                 suffixpressed: (){
  //                                                   ShopLoginCubit.get(context).changeVisibilty();
  //                                                 },
  //                                                 perfix: Icons.lock_outline,
  //                                                 validator: (value){
  //                                                   if(value!.isEmpty){
  //                                                     return 'Password is too short';
  //                                                   }
  //                                                 }
  //                                             ),
  //                                             const SizedBox(height: 30,),
  //                                             defaultformfield(
  //                                                 textEditingController: phoneController,
  //                                                 textInputType: TextInputType.phone,
  //                                                 perfix: Icons.phone,
  //                                                 label: 'Phone',
  //                                                 validator: (value){
  //                                                   if(value!.isEmpty){
  //                                                     return 'Phone must not be empty';
  //                                                   }
  //                                                 }
  //                                             ),
  //                                             const SizedBox(height: 30,),
  //                                             ConditionalBuilder(
  //                                               condition: state is! ShopRegisterLoadingStates,
  //                                               builder: (context)=>defaultbutton(
  //                                                   function: (){
  //                                                     if(formKey.currentState!.validate()){
  //                                                       ShopRegisterCubit.get(context).userRegister(
  //                                                           email: emailController.text,
  //                                                           password: passwordController.text,
  //                                                           name: nameController.text,
  //                                                           phone: phoneController.text
  //                                                       );
  //                                                     } else {
  //                                                       print('error');
  //                                                     }
  //
  //                                                   },
  //                                                   text: 'Register',
  //                                                   background: Colors.blue
  //                                               ),
  //                                               fallback: (context)=>Center(child: CircularProgressIndicator()),
  //                                             ),
  //                                             const SizedBox(height: 30,),
  //         ]),
  //             )
  //         )
  //         )
  //             )
  //         );
  //       },
  //     ),
  //     // child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
  //     //   listener: (context,state){
  //     //     if(state is ShopRegisterSuccessStates){
  //     //       if(state.loginModel.status!){
  //     //         print(state.loginModel.data?.token);
  //     //         print(state.loginModel.message);
  //     //
  //     //         CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value){
  //     //           if(value){
  //     //             token = state.loginModel.data!.token!;
  //     //             navigateFinish(context, ShopLayout());
  //     //           }
  //     //         });
  //     //       }else {
  //     //         print(state.loginModel.message);
  //     //         showToast(
  //     //             text:state.loginModel.message!,
  //     //             state: ToastStates.ERROR
  //     //         );
  //     //       }
  //     //     }
  //     //   },
  //     //   builder: (context,state){
  //     //     return Scaffold(
  //     //       appBar: AppBar(),
  //     //       body: Center(
  //     //         child: SingleChildScrollView(
  //     //           child: Padding(
  //     //             padding: const EdgeInsets.all(20.0),
  //     //             child: Form(
  //     //               key: formKey,
  //     //               child: Column(
  //     //                 crossAxisAlignment: CrossAxisAlignment.start,
  //     //                 children: [
  //     //                   Text(
  //     //                     'REGISTER',
  //     //                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontWeight: FontWeight.bold),
  //     //                   ),
  //     //                   const SizedBox(height: 15,),
  //     //                   Text(
  //     //                     'Register now to browse our hot offers ',
  //     //                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),
  //     //                   ),
  //     //                   const SizedBox(height: 30,),
  //     //                   defaultformfield(
  //     //                       textEditingController: nameController,
  //     //                       textInputType: TextInputType.name,
  //     //                       perfix: Icons.person,
  //     //                       label: 'Name ',
  //     //                       validator: (value){
  //     //                         if(value!.isEmpty){
  //     //                           return 'Name must not be empty';
  //     //                         }
  //     //                       }
  //     //                   ),
  //     //                   const SizedBox(height: 30,),
  //     //                   defaultformfield(
  //     //                       textEditingController: emailController,
  //     //                       textInputType: TextInputType.emailAddress,
  //     //                       perfix: Icons.email_outlined,
  //     //                       label: 'Email Address',
  //     //                       validator: (value){
  //     //                         if(value!.isEmpty){
  //     //                           return 'Email must not be empty';
  //     //                         }
  //     //                       }
  //     //                   ),
  //     //                   const SizedBox(height: 20,),
  //     //                   defaultformfield(
  //     //                       textEditingController: passwordController,
  //     //                       textInputType: TextInputType.visiblePassword,
  //     //                       label: 'Password ',
  //     //                       ispassword:ShopLoginCubit.get(context).ispassword,
  //     //                       suffix: ShopLoginCubit.get(context).suffix,
  //     //                       suffixpressed: (){
  //     //                         ShopLoginCubit.get(context).changeVisibilty();
  //     //                       },
  //     //                       perfix: Icons.lock_outline,
  //     //                       validator: (value){
  //     //                         if(value!.isEmpty){
  //     //                           return 'Password is too short';
  //     //                         }
  //     //                       }
  //     //                   ),
  //     //                   const SizedBox(height: 30,),
  //     //                   defaultformfield(
  //     //                       textEditingController: phoneController,
  //     //                       textInputType: TextInputType.phone,
  //     //                       perfix: Icons.phone,
  //     //                       label: 'Phone',
  //     //                       validator: (value){
  //     //                         if(value!.isEmpty){
  //     //                           return 'Phone must not be empty';
  //     //                         }
  //     //                       }
  //     //                   ),
  //     //                   const SizedBox(height: 30,),
  //     //                   ConditionalBuilder(
  //     //                     condition: state is! ShopRegisterLoadingStates,
  //     //                     builder: (context)=>defaultbutton(
  //     //                         function: (){
  //     //                           if(formKey.currentState!.validate()){
  //     //                             ShopRegisterCubit.get(context).userRegister(
  //     //                                 email: emailController.text,
  //     //                                 password: passwordController.text,
  //     //                                 name: nameController.text,
  //     //                                 phone: phoneController.text
  //     //                             );
  //     //                           } else {
  //     //                             print('error');
  //     //                           }
  //     //
  //     //                         },
  //     //                         text: 'Register',
  //     //                         background: Colors.blue
  //     //                     ),
  //     //                     fallback: (context)=>Center(child: CircularProgressIndicator()),
  //     //                   ),
  //     //                   const SizedBox(height: 30,),
  //     //                 ],
  //     //               ),
  //     //             ),
  //     //           ),
  //     //         ),
  //     //       ),
  //     //     );
  //     //   },
  //     //
  //     // ),
  //   );
  // }
}
