import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/counter_app/counter/cubit/states.dart';

// class CounterCubit extends Cubit<CounterStates> {
//   CounterCubit() : super(CounterInitialState());
//   static CounterCubit get(context) => BlocProvider.of(context);
//   int counter = 1;
//   void plus() {
//     counter++;
//     emit(CounterPlusState(counter));
//   }
//
//   void minus() {
//     counter--;
//     emit(CounterMinusState(counter));
//   }
// }

class CounterCubit extends Cubit<CounterStates> {
  static CounterCubit get(context) => BlocProvider.of(context);

  CounterCubit() : super(CounterInitialStates());
  int counter = 1;
  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }
}
