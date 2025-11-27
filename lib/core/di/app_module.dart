import 'package:dio/dio.dart';
import 'package:find_job/features/home/domain/repositories/job_repositories.dart';
import 'package:find_job/features/home/domain/usecases/job_apply_usecase.dart';
import 'package:find_job/features/home/presentation/store/apply_job_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:find_job/features/auth/presentations/login/store/auth_store.dart';
import 'package:find_job/features/auth/presentations/signup/store/signup_store.dart';
import 'package:find_job/features/home/data/datasource/job_remote_date_source.dart';
import 'package:find_job/features/home/data/repositories/job_repo_impl.dart';
import 'package:find_job/features/home/domain/usecases/job_usecases.dart';
import 'package:find_job/features/home/presentation/store/job_store.dart';
import 'package:find_job/features/my_jobs/store/my_jobs_store.dart';
import 'package:find_job/features/app_shell/store/navigation_store.dart';
import 'package:get_it/get_it.dart';
import 'package:find_job/core/network/dio_client.dart';
import 'package:find_job/core/network/network_info.dart';
import 'package:find_job/core/storage/secure_storage_service.dart';
import 'package:find_job/core/network/token_interceptor.dart';
import 'package:find_job/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:find_job/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:find_job/features/auth/domain/repositories/auth_repository.dart';
import 'package:find_job/features/auth/domain/usecases/auth_usecases.dart';

// Profile imports
import 'package:find_job/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:find_job/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:find_job/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:find_job/features/profile/domain/repositories/profile_repository.dart';
import 'package:find_job/features/profile/domain/usecases/profile_usecases.dart';
import 'package:find_job/features/profile/presentation/stores/profile_store.dart';
import 'package:find_job/features/profile/data/models/profile_model.dart';
import 'package:find_job/features/profile/data/models/education_model.dart';
import 'package:find_job/features/profile/data/models/experience_model.dart';
import 'package:find_job/features/profile/data/models/project_model.dart';
import 'package:find_job/features/profile/data/models/achievement_model.dart';

final sl = GetIt.asNewInstance();

Future<void> setUpLocator() async {
  // ----------------- HIVE INITIALIZATION -----------------
  await Hive.initFlutter();
  
  // Register Hive adapters
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(EducationModelAdapter());
  Hive.registerAdapter(ExperienceModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());
  Hive.registerAdapter(AchievementModelAdapter());

  // ----------------- CORE -----------------
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => SecureStorageService());
  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => TokenInterceptor(sl(), sl()));
  sl.registerLazySingleton(() => DioClient(sl(), sl()));

  // ----------------- AUTH FEATURE -----------------
  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl(), sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => AuthUseCases(sl()));

  // Stores
  sl.registerFactory(() => AuthStore(sl()));
  sl.registerFactory(() => SignUpStore(sl()));

// ----------------- JOBS -----------------
  sl.registerLazySingleton(
    () => JobRemoteDataSource(sl<DioClient>()),
  );

  sl.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(
      sl<JobRemoteDataSource>(),
      sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton(
    () => JobUseCases(sl<JobRepository>()),
  );

  sl.registerFactory(
    () => ApplyJobUseCase(sl<JobRepository>()),
  );

  sl.registerFactory(
    () => ApplyJobStore(sl<ApplyJobUseCase>()),
  );

  sl.registerFactory(
    () => JobStore(sl<JobUseCases>()),
  );

  // Navigation
  sl.registerFactory(() => NavigationStore());

  // My Jobs
  sl.registerFactory(() => MyJobsStore());

  // ----------------- PROFILE FEATURE -----------------
  // Data Sources
  sl.registerLazySingleton(() => ProfileLocalDataSource());
  sl.registerLazySingleton(() => ProfileRemoteDataSource());

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => ProfileUseCases(sl()));

  // Store
  sl.registerFactory(() => ProfileStore(sl()));

  
}
