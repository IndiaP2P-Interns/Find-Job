// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_jobs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyJobsStore on _MyJobsStore, Store {
  late final _$appliedJobsAtom =
      Atom(name: '_MyJobsStore.appliedJobs', context: context);

  @override
  ObservableList<Job> get appliedJobs {
    _$appliedJobsAtom.reportRead();
    return super.appliedJobs;
  }

  @override
  set appliedJobs(ObservableList<Job> value) {
    _$appliedJobsAtom.reportWrite(value, super.appliedJobs, () {
      super.appliedJobs = value;
    });
  }

  late final _$savedJobsAtom =
      Atom(name: '_MyJobsStore.savedJobs', context: context);

  @override
  ObservableList<Job> get savedJobs {
    _$savedJobsAtom.reportRead();
    return super.savedJobs;
  }

  @override
  set savedJobs(ObservableList<Job> value) {
    _$savedJobsAtom.reportWrite(value, super.savedJobs, () {
      super.savedJobs = value;
    });
  }

  late final _$stateAtom = Atom(name: '_MyJobsStore.state', context: context);

  @override
  Response<dynamic> get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(Response<dynamic> value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MyJobsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchAppliedJobsAsyncAction =
      AsyncAction('_MyJobsStore.fetchAppliedJobs', context: context);

  @override
  Future<void> fetchAppliedJobs() {
    return _$fetchAppliedJobsAsyncAction.run(() => super.fetchAppliedJobs());
  }

  late final _$fetchSavedJobsAsyncAction =
      AsyncAction('_MyJobsStore.fetchSavedJobs', context: context);

  @override
  Future<void> fetchSavedJobs() {
    return _$fetchSavedJobsAsyncAction.run(() => super.fetchSavedJobs());
  }

  late final _$_MyJobsStoreActionController =
      ActionController(name: '_MyJobsStore', context: context);

  @override
  void toggleSaveJob(Job job) {
    final _$actionInfo = _$_MyJobsStoreActionController.startAction(
        name: '_MyJobsStore.toggleSaveJob');
    try {
      return super.toggleSaveJob(job);
    } finally {
      _$_MyJobsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appliedJobs: ${appliedJobs},
savedJobs: ${savedJobs},
state: ${state},
isLoading: ${isLoading}
    ''';
  }
}
