 import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_information.dart';
import 'core/util/inpute_converte.dart';
import 'features/number_trivia/data/datasource/number_trivia_local_datasource.dart';
import 'features/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'features/number_trivia/data/repositories/number_triva_repositore_imp.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_ramdome_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';


 final sl = GetIt.instance;

 Future<void> init() async {
   sl.registerFactory(
           () => RandomNumberBloc(
           getConcreteRandomNumber: sl(),
           getRandomNumber: sl(),
           inputConverter: sl()));

   // Use cases
   sl.registerLazySingleton(() => GetConcreteRandomNumber(sl()));
   sl.registerLazySingleton(() => GetRandomNumber(sl()));

   // Repository
   sl.registerLazySingleton<RandomNumberRepository>(
         () => RandomNumberRepositoryImpl(
       localDataSource: sl(),
       networkInfo: sl(),
       remoteDataSource: sl(),
     ),
   );

   // Data sources
   sl.registerLazySingleton<RandomNumberRemoteDataSource>(
         () => RandomNumberRemoteDataSourceImpl(client: sl()),
   );

   sl.registerLazySingleton<RandomNumberLocalDataSource>(
         () => RandomNumberLocalDataSourceImpl(sharedPreferences: sl()),
   );

   //! Core
   sl.registerLazySingleton(() => InputConverter());
   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

   //! External
   final sharedPreferences = await SharedPreferences.getInstance();
   sl.registerLazySingleton(() => sharedPreferences);
   sl.registerLazySingleton(() => http.Client());
   sl.registerLazySingleton(() => DataConnectionChecker());
 }
