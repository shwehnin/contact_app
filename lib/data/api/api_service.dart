import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:contact_app/utils/constant.dart';
import 'package:contact_app/data/models/contact_model.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) => _ApiService(dio);

  @GET('news')
  Future<List<ContactModel>> getContact(
      @Query("page") int page, @Query("limit") int limit);

  @POST('news')
  Future<ContactModel> addContact(@Body() ContactModel contact);

  @PUT('news/{id}')
  Future<ContactModel> updateContact(
      @Path() String id, @Body() ContactModel contact);

  @DELETE('news/{id}')
  Future<ContactModel> deleteContact(@Path() String id);
}
