import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/shop_app/cubit/states.dart';
import 'package:flutter_project/modules/shop_app/search/search_screen.dart';
import 'package:flutter_project/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'SALLA'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home
                  ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.apps
                  ),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite
                  ),
                  label: 'Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings
                  ),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },

    );
  }
}
