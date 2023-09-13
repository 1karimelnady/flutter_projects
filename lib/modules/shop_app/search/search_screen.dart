import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/shop_app/search/cubit/cubit.dart';
import 'package:flutter_project/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_project/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultformfield(
                        textEditingController: text,
                        textInputType: TextInputType.text,
                        label: 'Search',
                        perfix: Icons.search,
                        onSubmit: (text) {
                          SearchCubit.get(context).searchData(text!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter to search';
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data![index],
                              context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
