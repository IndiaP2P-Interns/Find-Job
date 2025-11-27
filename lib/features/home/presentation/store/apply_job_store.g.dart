// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_job_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApplyJobStore on _ApplyJobStore, Store {
  late final _$isApplyingAtom =
      Atom(name: '_ApplyJobStore.isApplying', context: context);

  @override
  bool get isApplying {
    _$isApplyingAtom.reportRead();
    return super.isApplying;
  }

  @override
  set isApplying(bool value) {
    _$isApplyingAtom.reportWrite(value, super.isApplying, () {
      super.isApplying = value;
    });
  }

  late final _$statusMessageAtom =
      Atom(name: '_ApplyJobStore.statusMessage', context: context);

  @override
  String get statusMessage {
    _$statusMessageAtom.reportRead();
    return super.statusMessage;
  }

  @override
  set statusMessage(String value) {
    _$statusMessageAtom.reportWrite(value, super.statusMessage, () {
      super.statusMessage = value;
    });
  }

  late final _$progressAtom =
      Atom(name: '_ApplyJobStore.progress', context: context);

  @override
  int get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(int value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$errorAtom = Atom(name: '_ApplyJobStore.error', context: context);

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

  late final _$applyAsyncAction =
      AsyncAction('_ApplyJobStore.apply', context: context);

  @override
  Future<void> apply(String jobId, String filePath) {
    return _$applyAsyncAction.run(() => super.apply(jobId, filePath));
  }

  late final _$_ApplyJobStoreActionController =
      ActionController(name: '_ApplyJobStore', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_ApplyJobStoreActionController.startAction(
        name: '_ApplyJobStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ApplyJobStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isApplying: ${isApplying},
statusMessage: ${statusMessage},
progress: ${progress},
error: ${error}
    ''';
  }
}
