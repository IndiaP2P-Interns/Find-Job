// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$JobStore on _JobStore, Store {
  Computed<bool>? _$showErrorStateComputed;

  @override
  bool get showErrorState =>
      (_$showErrorStateComputed ??= Computed<bool>(() => super.showErrorState,
              name: '_JobStore.showErrorState'))
          .value;

  late final _$jobsAtom = Atom(name: '_JobStore.jobs', context: context);

  @override
  ObservableList<Job> get jobs {
    _$jobsAtom.reportRead();
    return super.jobs;
  }

  @override
  set jobs(ObservableList<Job> value) {
    _$jobsAtom.reportWrite(value, super.jobs, () {
      super.jobs = value;
    });
  }

  late final _$pageAtom = Atom(name: '_JobStore.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$hasMoreAtom = Atom(name: '_JobStore.hasMore', context: context);

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_JobStore.isLoading', context: context);

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

  late final _$errorAtom = Atom(name: '_JobStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_JobStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$filtersAtom = Atom(name: '_JobStore.filters', context: context);

  @override
  JobFilters get filters {
    _$filtersAtom.reportRead();
    return super.filters;
  }

  @override
  set filters(JobFilters value) {
    _$filtersAtom.reportWrite(value, super.filters, () {
      super.filters = value;
    });
  }

  late final _$showFilterAtom =
      Atom(name: '_JobStore.showFilter', context: context);

  @override
  bool get showFilter {
    _$showFilterAtom.reportRead();
    return super.showFilter;
  }

  @override
  set showFilter(bool value) {
    _$showFilterAtom.reportWrite(value, super.showFilter, () {
      super.showFilter = value;
    });
  }

  late final _$fetchJobsAsyncAction =
      AsyncAction('_JobStore.fetchJobs', context: context);

  @override
  Future<void> fetchJobs({bool loadMore = false}) {
    return _$fetchJobsAsyncAction
        .run(() => super.fetchJobs(loadMore: loadMore));
  }

  late final _$_JobStoreActionController =
      ActionController(name: '_JobStore', context: context);

  @override
  void setSearchQuery(String q) {
    final _$actionInfo = _$_JobStoreActionController.startAction(
        name: '_JobStore.setSearchQuery');
    try {
      return super.setSearchQuery(q);
    } finally {
      _$_JobStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowFilter() {
    final _$actionInfo = _$_JobStoreActionController.startAction(
        name: '_JobStore.toggleShowFilter');
    try {
      return super.toggleShowFilter();
    } finally {
      _$_JobStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilters(JobFilters f) {
    final _$actionInfo =
        _$_JobStoreActionController.startAction(name: '_JobStore.setFilters');
    try {
      return super.setFilters(f);
    } finally {
      _$_JobStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
jobs: ${jobs},
page: ${page},
hasMore: ${hasMore},
isLoading: ${isLoading},
error: ${error},
searchQuery: ${searchQuery},
filters: ${filters},
showFilter: ${showFilter},
showErrorState: ${showErrorState}
    ''';
  }
}
