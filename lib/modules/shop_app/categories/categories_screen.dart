import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/shop_app/cubit/states.dart';
import 'package:flutter_project/models/shop_model/categories_model.dart';

import '../../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).categoriesModel != null,
              builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCategoriesItem(
                      ShopCubit.get(context)
                          .categoriesModel!
                          .data!
                          .data[index]),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopCubit.get(context)
                      .categoriesModel!
                      .data!
                      .data
                      .length),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }

  Widget buildCategoriesItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              image: NetworkImage('${model.image}'),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
