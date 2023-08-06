import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_manager/features/auth/domain/use_cases/logout.dart';
import 'package:task_manager/features/auth/domain/use_cases/signup.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth_bloc.dart';

import 'core/platform/network_info.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/use_cases/login.dart';
import 'features/tasks/data/datasources/task_local_data_source.dart';
import 'features/tasks/data/repositories/post_repository_impl.dart';
import 'features/tasks/domain/repositories/tasks_repository.dart';
import 'features/tasks/domain/usecases/add_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_all_tasks.dart';
import 'features/tasks/domain/usecases/update_task.dart';
import 'features/tasks/presentation/bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import 'features/tasks/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Authentication

//  Bloc
  sl.registerFactory(() =>
      AuthBloc(logoutUsecase: sl(), signupUsecase: sl(), loginUsecase: sl()));

//  Use-cases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
//   Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: sl(), networkInfo: sl()));
//   Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

//! Features - Posts

//  Bloc
  sl.registerFactory(() => PostsBloc(getAllTasks: sl()));
  sl.registerFactory(() => AddDeleteUpdateTaskBloc(
      addTaskUsecase: sl(), updateTaskUsecase: sl(), deleteTaskUsecase: sl()));

//  Use-cases
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
//   Repository
  sl.registerLazySingleton<TasksRepository>(
      () => TasksRepositoryImpl(localDataSource: sl(), networkInfo: sl()));
//   Data sources
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl());
//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
