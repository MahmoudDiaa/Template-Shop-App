import 'package:boilerplate/data/respository/incident_repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../data/respository/incident_repository.dart';
import '../../models/incident/incident.dart';
import '../../models/incident/incident_filter.dart';
import '../../models/incident/incident_list.dart';
import '../../models/incident/incident_list.dart';
import '../../utils/dio/dio_error_util.dart';

part 'incident_store.g.dart';

class IncidentStore = _IncidentStore with _$IncidentStore;

abstract class _IncidentStore with Store {
  // repository instance
  late IncidentRepository _incidentRepository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _IncidentStore(IncidentRepository incidentRepository)
      : this._incidentRepository = incidentRepository;

  static ObservableFuture<IncidentList?> emptyIncidentResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<IncidentList?> fetchIncidentsFuture =
      ObservableFuture<IncidentList?>(emptyIncidentResponse);

  @observable
  ObservableFuture<IncidentList?> fetchMoreIncidentsFuture =
      ObservableFuture<IncidentList?>(emptyIncidentResponse);

  @observable
  ObservableFuture<Incident?> fetchIncidentFuture =
      ObservableFuture<Incident?>(ObservableFuture.value(null));

  @observable
  IncidentList? incidentList;

  @observable
  Incident? incident;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchIncidentsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingMore =>
      fetchMoreIncidentsFuture.status == FutureStatus.pending;

  @computed
  bool get gettingIncident =>
      fetchIncidentFuture.status == FutureStatus.pending;

  int _pageNumber = 1;

  @action
  Future getIncidents({IncidentFilter? incidentFilter}) async {
    this._pageNumber = 1;
    final future = _incidentRepository.getIncidents(
        pageNumber: _pageNumber, incidentFilter: incidentFilter);
    fetchIncidentsFuture = ObservableFuture(future);
    future.then((incidentList) {
      if (incidentList.incidents!.length > 0) _pageNumber++;
      this.incidentList = incidentList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getMore({IncidentFilter? incidentFilter}) async {
    final future = _incidentRepository.getIncidents(
        pageNumber: _pageNumber, incidentFilter: incidentFilter);
    fetchMoreIncidentsFuture = ObservableFuture(future);
    future.then((incidentList) {
      if (incidentList.incidents!.length > 0) _pageNumber++;
      if (this.incidentList == null)
        this.incidentList = incidentList;
      else {
        this.incidentList!.appendItems(incidentList?.incidents ?? <Incident>[]);
        this.incidentList = this.incidentList;
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getIncident(String id) async {
    final future = _incidentRepository.getIncidentById(id);
    fetchIncidentFuture = ObservableFuture(future);
    future.then((incident) {
      this.incident = incident;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
