import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layouts/news_app/cubit/cubit.dart';
import 'package:flutter_project/layouts/news_app/cubit/states.dart';
import 'package:flutter_project/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, NewsStates state) {},
      builder: (BuildContext context, NewsStates state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                defaultformfield(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Search not be empty";
                    }
                  },
                    textEditingController: controller,
                    textInputType: TextInputType.text,
                    label: 'search',
                    perfix: Icons.search,
                    onChange: (value) {
                      NewsCubit.get(context).getSearch(value!);
                    }),
                Expanded(child: articleBuilder(list, isSearch: true))
              ],
            ),
          ),
        );
      },
    );
  }
}
