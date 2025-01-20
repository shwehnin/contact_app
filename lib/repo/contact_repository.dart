import 'package:contact_app/data/api/api_service.dart';
import 'package:contact_app/data/models/contact_model.dart';

class ContactRepository {
  final ApiService _apiService;
  ContactRepository(this._apiService);

  Future<List<ContactModel>> getContact(
          {required int page, required int limit}) =>
      _apiService.getContact(page, limit);

  Future<ContactModel> addContact(ContactModel contact) =>
      _apiService.addContact(contact);

  Future<ContactModel> updateContact(String id, ContactModel contact) =>
      _apiService.updateContact(id, contact);

  Future<ContactModel> deleteContact(String id) =>
      _apiService.deleteContact(id);
}
