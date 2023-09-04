import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/shop_app/cubit/states.dart';
import 'package:flutter_project/models/shop_model/home_model.dart';
import 'package:flutter_project/shared/styles/colors/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).home_model != null,
              builder: (context) =>
                  productsBuilder(ShopCubit.get(context).home_model!),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: model.data?.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(seconds: 1),
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  childAspectRatio: 1 / 1.54,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: List.generate(
                      model.data!.products.length,
                      (index) =>
                          buildGridProduct(model.data!.products[index]))),
            ),
          ],
        ),
      );

  Widget buildGridProduct(productModel model) => Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  height: 200,
                  width: double.infinity,
                  image: NetworkImage(
                    model.image!,
                  )),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(fontSize: 12.0, color: primarycolor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          size: 14,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ]),
      );
}
