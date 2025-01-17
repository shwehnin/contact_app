import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:contact_app/data/api/api_service.dart';
import 'package:contact_app/repo/contact_repository.dart';

var getIt = GetIt.I;

void locator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerLazySingleton(() => contactRepository);
}
