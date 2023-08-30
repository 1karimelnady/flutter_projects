import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:flutter_project/modules/done_tasks/done_tasks_screen.dart';
import 'package:flutter_project/modules/new_tasks/new_tasks_screen.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currenindex = 0;
  List<Widget> screen = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  Database? database;
  void createDatebase() {
    openDatabase('todo.dp', version: 1, onCreate: (database, version) {
      print('Create Database');
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT ,time Text,date TEXT,status TEXT)')
          .then((value) {
        print('Table created');
      }).catchError((error) {
        print('ERROR when created Database${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Database open');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks (title,date,status) VALUES ("$title","$date","new")');
    }).then((value) {
      print('$value Inserted Successfully');
      getDataFromDatabase(database);
      emit(AppInsertDatabaseState());
    }).catchError((error) {
      print('ERROR when inserted into  Database ${error.toString()}');
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppLoadingDatabaseState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
    });
  }

  void UpdateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['${status}', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void DeleteData({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeindex(int index) {
    currenindex = index;
    emit(AppBottomNavBarState());
  }

  bool isopen = false;
  IconData icon = Icons.edit;
  void ChangeBottomSheet({
    required bool isshow,
    required IconData fabicon,
  }) {
    isopen = isshow;
    icon = fabicon;
    emit(AppBottomSheetState());
  }
}
