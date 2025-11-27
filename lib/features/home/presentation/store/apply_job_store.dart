// lib/features/home/presentation/stores/apply_job_store.dart
import 'package:find_job/features/home/domain/usecases/job_apply_usecase.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/response_state.dart';

part 'apply_job_store.g.dart';

class ApplyJobStore = _ApplyJobStore with _$ApplyJobStore;

abstract class _ApplyJobStore with Store {
  final ApplyJobUseCase useCase;

  _ApplyJobStore(this.useCase);

  @observable
  bool isApplying = false;

  @observable
  String statusMessage = '';

  @observable
  int progress = 0; // 0..100

  @observable
  String? error;

  @action
  Future<void> apply(String jobId, String filePath) async {
    isApplying = true;
    statusMessage = 'Starting...';
    progress = 0;
    error = null;

    final res = await useCase.call(jobId, filePath, onProgress: (msg, pct) {
      statusMessage = msg;
      progress = pct;
    });

    if (res is Success<void>) {
      statusMessage = 'Done';
      progress = 100;
      isApplying = false;
    } else if (res is Error<void>) {
      error = res.message;
      isApplying = false;
    } else {
      isApplying = false;
      error = 'Unknown error';
    }
  }

  @action
  void reset() {
    isApplying = false;
    statusMessage = '';
    progress = 0;
    error = null;
  }
}
