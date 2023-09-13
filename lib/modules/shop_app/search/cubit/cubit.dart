import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_project/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_model/search_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/endpoints.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void searchData(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
