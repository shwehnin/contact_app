import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:contact_app/data/api/api_service.dart';
import 'package:contact_app/repo/contact_repository.dart';
import 'package:contact_app/blocs/get/cubit/get_contact_cubit.dart';

var getIt = GetIt.I;

void serviceLocator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerLazySingleton(() => contactRepository);

  GetContactCubit getContactCubit = GetContactCubit(getIt.call());
  getIt.registerLazySingleton(() => getContactCubit);
}
