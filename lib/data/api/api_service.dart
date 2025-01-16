import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:contact_app/utils/constant.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) => _ApiService(dio);
}
