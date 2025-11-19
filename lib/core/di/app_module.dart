import 'package:dio/dio.dart';
import 'package:find_job/auth/presentations/login/store/auth_store.dart';
import 'package:find_job/auth/presentations/signup/store/signup_store.dart';
import 'package:find_job/main/home/data/datasource/job_remote_date_source.dart';
import 'package:find_job/main/home/data/repositories/job_repo_impl.dart';
import 'package:find_job/main/home/domain/usecases/job_usecases.dart';
import 'package:find_job/main/home/presentation/store/job_store.dart';
import 'package:find_job/main/navigation/store/navigation_store.dart';
import 'package:get_it/get_it.dart';
import 'package:find_job/core/network/dio_client.dart';
import 'package:find_job/core/network/network_info.dart';
import 'package:find_job/core/storage/secure_storage_service.dart';
import 'package:find_job/core/network/token_interceptor.dart';
import 'package:find_job/auth/data/datasources/auth_remote_data_source.dart';
import 'package:find_job/auth/data/repositories/auth_repository_impl.dart';
import 'package:find_job/auth/domain/repositories/auth_repository.dart';
import 'package:find_job/auth/domain/usecases/auth_usecases.dart';

final sl = GetIt.asNewInstance();

Future<void> setUpLocator() async {
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

  // Jobs feature
  sl.registerLazySingleton(() => JobRemoteDataSource(sl<DioClient>()));
  sl.registerLazySingleton(
    () => JobRepositoryImpl(sl<JobRemoteDataSource>(), sl<NetworkInfo>()),
  );
  sl.registerLazySingleton(() => JobUseCases(sl<JobRepositoryImpl>()));
  sl.registerFactory(() => JobStore(sl<JobUseCases>()));

  // Navigation
  sl.registerFactory(() => NavigationStore());
}
