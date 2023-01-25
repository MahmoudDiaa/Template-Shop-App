import 'package:boilerplate/data/local/datasources/priorities/priority_datasource.dart';
import 'package:boilerplate/data/network/apis/priorities/priorities_api.dart';
import 'package:boilerplate/models/PriorityLevels%20/Priority_level_list.dart';
import 'package:boilerplate/models/PriorityLevels%20/priorrity_level.dart';
import 'package:sembast/sembast.dart';
import '../local/constants/db_constants.dart';

class PriorityRepository {


  // Future<PriorityLevelList> getPriorities() async {
  //   return PriorityLevelList(priorities: <PriorityLevel>[
  //     PriorityLevel(id: 1, arabicName: 'منخفض', englishName: 'Low'),
  //     PriorityLevel(id: 2, arabicName: 'متوسط', englishName: 'Medium'),
  //     PriorityLevel(id: 3, arabicName: 'عالى', englishName: 'High'),
  //   ]);
  // }



  //data source priorities
  final PrioritiesDataSource _priorityDataSource;
  //api priorities
  final prioritiesApi _prioritiesApi;


  PriorityRepository(this._priorityDataSource, this._prioritiesApi);
//priorities

  // priorities: ---------------------------------------------------------------------
  Future<PriorityLevelList> getPriorities() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _prioritiesApi.getPriorities().then((prioritiesList) {
      prioritiesList.priorities?.forEach((priority) {
        _priorityDataSource.insert(priority);
      });

      return prioritiesList;
    }).catchError((error) => throw error);
  }

  Future<List<PriorityLevel>> findPriorityById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _priorityDataSource
        .getAllSortedByFilter(filters: filters)
        .then((priorities) => priorities)
        .catchError((error) => throw error);
  }

  Future<int> insertPriority(PriorityLevel priorityLevel) => _priorityDataSource
      .insert(priorityLevel)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> updatePriority(PriorityLevel priorityLevel) => _priorityDataSource
      .update(priorityLevel)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> deletePriority(PriorityLevel priorityLevel) => _priorityDataSource
      .update(priorityLevel)
      .then((id) => id)
      .catchError((error) => throw error);
}
