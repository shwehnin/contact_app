import 'package:contact_app/data/api/api_service.dart';
import 'package:contact_app/data/models/contact_model.dart';

class ContactRepository {
  final ApiService _apiService;
  ContactRepository(this._apiService);

  Future<List<ContactModel>> getContact() => _apiService.getContact();

  Future<ContactModel> addContact(ContactModel contact) =>
      _apiService.addContact(contact);

  Future<ContactModel> updateContact(String id, ContactModel contact) =>
      _apiService.updateContact(id, contact);

  Future<ContactModel> deleteContact(String id) =>
      _apiService.deleteContact(id);
}
