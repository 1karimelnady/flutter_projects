import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/shared/components/components.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  List<String> text = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  var scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatebase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                text[cubit.currenindex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isopen) {
                  cubit.insertToDatabase(
                    title: titleController.text,
                    date: dateController.text,
                  );
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsets.all(20.0),
                            color: Colors.grey[100],
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultformfield(
                                    textEditingController: titleController,
                                    textInputType: TextInputType.text,
                                    label: 'Task Title',
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  // defaultformfield(
                                  //   ontap: () {
                                  //     showTimePicker(
                                  //             context: context,
                                  //             initialTime: TimeOfDay.now())
                                  //         .then((value) => {
                                  //               timeController.text =
                                  //                   value!.format(context).toString()
                                  //             });
                                  //   },
                                  //   textEditingController: timeController,
                                  //   textInputType: TextInputType.text,
                                  //   label: 'Task Time',
                                  // ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultformfield(
                                    ontap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2023-11-05"),
                                      ).then((value) => {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!),
                                          });
                                    },
                                    textEditingController: dateController,
                                    textInputType: TextInputType.text,
                                    label: 'Task Date',
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.ChangeBottomSheet(isshow: false, fabicon: Icons.edit);
                  });
                  cubit.ChangeBottomSheet(
                    isshow: true,
                    fabicon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.icon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currenindex,
              onTap: (index) {
                cubit.changeindex(index);
              },
              items: [
                const BottomNavigationBarItem(
                    label: 'Tasks', icon: Icon(Icons.menu)),
                const BottomNavigationBarItem(
                    label: 'Done', icon: Icon(Icons.check_circle_outline)),
                const BottomNavigationBarItem(
                    label: 'Archived', icon: Icon(Icons.archive_outlined)),
              ],
            ),
            body: ConditionalBuilder(
              builder: (context) => cubit.screen[cubit.currenindex],
              condition: state is! AppLoadingDatabaseState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
