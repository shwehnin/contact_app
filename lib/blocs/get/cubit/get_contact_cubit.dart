import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:contact_app/repo/contact_repository.dart';
import 'package:contact_app/data/models/contact_model.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  final ContactRepository _contactRepository;
  List<ContactModel> _contacts = [];
  int _currentPage = 1;
  int _limit = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  GetContactCubit(this._contactRepository) : super(GetContactInitial()) {
    getContact();
  }

  Future<void> getContact({bool isLoadMore = false, String query = ''}) async {
    if (!isLoadMore) {
      emit(GetContactLoading());
      _currentPage = 1;
      _hasMore = true;
      _contacts.clear();
      _searchQuery = query;
    } else if (!_hasMore) {
      return;
    }

    try {
      final data = query.isEmpty
          ? await _contactRepository.getContact(
              page: _currentPage, limit: _limit)
          : await _contactRepository.searchContacts(
              query: query, page: _currentPage, limit: _limit);
      if (data.isEmpty || data.length < _limit) {
        _hasMore = false;
      }
      if (!isLoadMore) {
        _contacts = data;
      } else {
        _contacts.addAll(data);
      }
      _currentPage++;
      emit(GetContactSuccess(contactList: List.from(_contacts)));
    } catch (e) {
      emit(GetContactFailure(message: "Contact List Error $e"));
    }
    // _contactRepository
    //     .getContact()
    //     .then((data) => emit(GetContactSuccess(contactList: data)))
    //     .catchError(
    //         (e) => emit(GetContactFailure(message: "Contact List Error $e")));
  }

  void searchContacts(String query) async {
    if (query.isEmpty) {
      getContact();
    } else {
      getContact(query: query);
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
