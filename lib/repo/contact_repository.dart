import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:contact_app/data/api/api_service.dart';
import 'package:contact_app/data/models/contact_model.dart';

class ContactRepository {
  final ApiService _apiService;
  ContactRepository(this._apiService);

  Future<List<ContactModel>> getContact(
      {required int page, required int limit}) async {
    try {
      return await _apiService.getContact(page, limit);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }

  Future<List<ContactModel>> searchContacts(
      {required String query, required int page, required int limit}) async {
    try {
      return await _apiService.searchContacts(query, page, limit);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }

  Future<ContactModel> addContact(ContactModel contact) =>
      _apiService.addContact(contact);

  Future<ContactModel> updateContact(String id, ContactModel contact) =>
      _apiService.updateContact(id, contact);

  Future<ContactModel> deleteContact(String id) =>
      _apiService.deleteContact(id);
}
