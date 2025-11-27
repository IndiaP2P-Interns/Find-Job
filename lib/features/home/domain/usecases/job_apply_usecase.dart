// lib/features/home/domain/usecases/apply_job_usecase.dart
import '../repositories/job_repositories.dart';
import '../../../../core/response_state.dart';

class ApplyJobUseCase {
  final JobRepository repository;
  ApplyJobUseCase(this.repository);

  Future<Response<void>> call(String jobId, String filePath, {Function(String,int)? onProgress}) {
    return repository.applyJob(jobId, filePath, onProgress: onProgress);
  }
}
