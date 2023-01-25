import 'package:boilerplate/data/respository/priority_repository.dart';
import 'package:boilerplate/models/PriorityLevels%20/Priority_level_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../utils/dio/dio_error_util.dart';

part 'priority_store.g.dart';

class PriorityStore = _PriorityStore with _$PriorityStore;

abstract class _PriorityStore with Store {
  // repository instance
  late PriorityRepository _priorityRepository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PriorityStore(PriorityRepository priorityRepository)
      : this._priorityRepository = priorityRepository;

  static ObservableFuture<PriorityLevelList?> emptyPriorityResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<PriorityLevelList?> fetchPrioritiesFuture =
      ObservableFuture<PriorityLevelList?>(emptyPriorityResponse);

  @observable
  PriorityLevelList? priorityList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPrioritiesFuture.status == FutureStatus.pending;

  @action
  Future getPriorities() async {
    final future = _priorityRepository.getPriorities();
    fetchPrioritiesFuture = ObservableFuture(future);
    future.then((priorityList) {
      this.priorityList = priorityList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
