import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:contact_app/repo/contact_repository.dart';
import 'package:contact_app/data/models/contact_model.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  final ContactRepository _contactRepository;
  List<ContactModel> _contacts = [];
  int _currentPage = 1;
  final int _limit = 10;
  bool _isLastPage = false;

  GetContactCubit(this._contactRepository) : super(GetContactInitial()) {
    getContact();
  }

  Future<bool> getContact({bool isLoadMore = false}) async {
    if (_isLastPage && isLoadMore) return false;
    if (!isLoadMore) {
      emit(GetContactLoading());
    } else {
      emit(GetContactSuccess(contactList: _contacts, isLastpage: _isLastPage));
    }
    try {
      final data = await _contactRepository.getContact(
          page: _currentPage, limit: _limit);
      if (data.isEmpty) {
        _isLastPage = true;
      } else {
        if (isLoadMore) {
          _contacts.addAll(data);
        } else {
          _contacts = data;
        }
        _currentPage++;
      }
      emit(GetContactSuccess(contactList: _contacts, isLastpage: _isLastPage));
      return true;
    } catch (e) {
      emit(GetContactFailure(message: "Contact List Error $e"));
      return false;
    }
    // _contactRepository
    //     .getContact()
    //     .then((data) => emit(GetContactSuccess(contactList: data)))
    //     .catchError(
    //         (e) => emit(GetContactFailure(message: "Contact List Error $e")));
  }

  void searchContacts(String query) async {
    emit(GetContactLoading());
    try {
      final data = await _contactRepository.searchContacts(query);
      emit(GetContactSuccess(contactList: data, isLastpage: _isLastPage));
    } catch (e) {
      emit(GetContactFailure(message: "Search error: $e"));
    }
  }

  void deleteContact(String id) {
    emit(GetContactLoading());
    _contactRepository
        .deleteContact(id)
        .then((data) => getContact())
        .catchError(
            (e) => emit(GetContactFailure(message: "Contact delete error $e")));
  }
}
