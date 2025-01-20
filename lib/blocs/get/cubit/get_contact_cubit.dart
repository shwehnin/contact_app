import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:contact_app/repo/contact_repository.dart';
import 'package:contact_app/data/models/contact_model.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  final ContactRepository _contactRepository;
  GetContactCubit(this._contactRepository) : super(GetContactInitial()) {
    getContact();
  }

  void getContact() {
    emit(GetContactLoading());
    _contactRepository
        .getContact()
        .then((data) => emit(GetContactSuccess(contactList: data)))
        .catchError(
            (e) => emit(GetContactFailure(message: "Contact List Error $e")));
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
