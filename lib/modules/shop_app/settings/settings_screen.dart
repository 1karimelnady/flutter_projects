import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/shop_app/cubit/states.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:flutter_project/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
  var nameController = TextEditingController();
   var emailController = TextEditingController();
   var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model!.data!.email!;
          phoneController.text = model!.data!.phone!;
          return ConditionalBuilder(
              condition: ShopCubit.get(context).userModel!=null,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultformfield(
                        textEditingController: nameController,
                        textInputType: TextInputType.text,
                        perfix: Icons.person,
                        label: 'Name',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Name must not b empty';
                          }
                        }
                    ),
                    SizedBox(height: 20.0,),
                    defaultformfield(
                        textEditingController: emailController,
                        textInputType: TextInputType.emailAddress,
                        perfix: Icons.email,
                        label: 'Email',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Email must not b empty';
                          }
                        }
                    ),
                    SizedBox(height: 20.0,),
                    defaultformfield(
                        textEditingController: phoneController,
                        textInputType: TextInputType.text,
                        perfix: Icons.call,
                        label: 'Phone',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Phone must not b empty';
                          }
                        }
                    ),
                    SizedBox(height: 20.0,),
                    defaultbutton(function: (){
                      signOut(context);
                    }, text: 'Logout')

                  ],
                ),
              ),
              fallback:(context)=> Center(child: CircularProgressIndicator(),)
          );
        },
        listener: (context,state){}
    );
  }
}
