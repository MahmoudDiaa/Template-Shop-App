import 'package:bloc/bloc.dart';
import 'package:bmw/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;

  int currentIndex = 0;
  List<Widget> screens = [

  ];
  List<String> title = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  bool isBottomSheetShown = false;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void createDatabase() {
    openDatabase('todo.db',
        onCreate: (database, version) {
          database
              .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT ,time TEXT ,date TEXT,status TEXT)')
              .then((value) => {print('create data base ')})
              .catchError((e) {
            print(e.toString());
          });
        },
        version: 1,
        onOpen: (database) {
          getDataFromDatabase(database);
        }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database!);
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  void getDataFromDatabase(Database database) {
    emit(AppGetDatabaseLoadingState());
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // setState(() {
      value.forEach((element) {
        print('element status $element');
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
      // });
    });
  }

  void updateData({required String status, required int id}) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database!);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({ required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?',
        [id]).then((value) {
      getDataFromDatabase(database!);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeBottomSheetState(isShow) {
    isBottomSheetShown = isShow;
    emit(AppChangeBottomNavState());
  }

  bool isDark = false;

  void changeDarkState() {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeDarkModeState());
    });
  }

}

