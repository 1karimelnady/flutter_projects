import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterPlusState) {
            if (kDebugMode) {
              print('plus state ${state.counter}');
            }
          }
          if (state is CounterMinusState) {
            if (kDebugMode) {
              print('plus state ${state.counter}');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: const Text(
                        'Plus',
                        style: TextStyle(fontSize: 25.0),
                      )),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: const TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: const Text(
                        'Minus',
                        style: TextStyle(fontSize: 25.0),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
