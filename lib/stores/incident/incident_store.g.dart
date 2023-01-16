// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$IncidentStore on _IncidentStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_IncidentStore.loading'))
      .value;
  Computed<bool>? _$loadingMoreComputed;

  @override
  bool get loadingMore =>
      (_$loadingMoreComputed ??= Computed<bool>(() => super.loadingMore,
              name: '_IncidentStore.loadingMore'))
          .value;
  Computed<bool>? _$gettingIncidentComputed;

  @override
  bool get gettingIncident =>
      (_$gettingIncidentComputed ??= Computed<bool>(() => super.gettingIncident,
              name: '_IncidentStore.gettingIncident'))
          .value;

  final _$fetchIncidentsFutureAtom =
      Atom(name: '_IncidentStore.fetchIncidentsFuture');

  @override
  ObservableFuture<IncidentList?> get fetchIncidentsFuture {
    _$fetchIncidentsFutureAtom.reportRead();
    return super.fetchIncidentsFuture;
  }

  @override
  set fetchIncidentsFuture(ObservableFuture<IncidentList?> value) {
    _$fetchIncidentsFutureAtom.reportWrite(value, super.fetchIncidentsFuture,
        () {
      super.fetchIncidentsFuture = value;
    });
  }

  final _$fetchMoreIncidentsFutureAtom =
      Atom(name: '_IncidentStore.fetchMoreIncidentsFuture');

  @override
  ObservableFuture<IncidentList?> get fetchMoreIncidentsFuture {
    _$fetchMoreIncidentsFutureAtom.reportRead();
    return super.fetchMoreIncidentsFuture;
  }

  @override
  set fetchMoreIncidentsFuture(ObservableFuture<IncidentList?> value) {
    _$fetchMoreIncidentsFutureAtom
        .reportWrite(value, super.fetchMoreIncidentsFuture, () {
      super.fetchMoreIncidentsFuture = value;
    });
  }

  final _$fetchIncidentFutureAtom =
      Atom(name: '_IncidentStore.fetchIncidentFuture');

  @override
  ObservableFuture<Incident?> get fetchIncidentFuture {
    _$fetchIncidentFutureAtom.reportRead();
    return super.fetchIncidentFuture;
  }

  @override
  set fetchIncidentFuture(ObservableFuture<Incident?> value) {
    _$fetchIncidentFutureAtom.reportWrite(value, super.fetchIncidentFuture, () {
      super.fetchIncidentFuture = value;
    });
  }

  final _$incidentListAtom = Atom(name: '_IncidentStore.incidentList');

  @override
  IncidentList? get incidentList {
    _$incidentListAtom.reportRead();
    return super.incidentList;
  }

  @override
  set incidentList(IncidentList? value) {
    _$incidentListAtom.reportWrite(value, super.incidentList, () {
      super.incidentList = value;
    });
  }

  final _$incidentAtom = Atom(name: '_IncidentStore.incident');

  @override
  Incident? get incident {
    _$incidentAtom.reportRead();
    return super.incident;
  }

  @override
  set incident(Incident? value) {
    _$incidentAtom.reportWrite(value, super.incident, () {
      super.incident = value;
    });
  }

  final _$successAtom = Atom(name: '_IncidentStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$getIncidentsAsyncAction = AsyncAction('_IncidentStore.getIncidents');

  @override
  Future<dynamic> getIncidents({IncidentFilter? incidentFilter}) {
    return _$getIncidentsAsyncAction
        .run(() => super.getIncidents(incidentFilter: incidentFilter));
  }

  final _$getMoreAsyncAction = AsyncAction('_IncidentStore.getMore');

  @override
  Future<dynamic> getMore({IncidentFilter? incidentFilter}) {
    return _$getMoreAsyncAction
        .run(() => super.getMore(incidentFilter: incidentFilter));
  }

  final _$getIncidentAsyncAction = AsyncAction('_IncidentStore.getIncident');

  @override
  Future<dynamic> getIncident(String id) {
    return _$getIncidentAsyncAction.run(() => super.getIncident(id));
  }

  @override
  String toString() {
    return '''
fetchIncidentsFuture: ${fetchIncidentsFuture},
fetchMoreIncidentsFuture: ${fetchMoreIncidentsFuture},
fetchIncidentFuture: ${fetchIncidentFuture},
incidentList: ${incidentList},
incident: ${incident},
success: ${success},
loading: ${loading},
loadingMore: ${loadingMore},
gettingIncident: ${gettingIncident}
    ''';
  }
}
