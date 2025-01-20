import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:contact_app/repo/contact_repository.dart';
import 'package:contact_app/data/models/contact_model.dart';

part 'edit_contact_state.dart';

class EditContactCubit extends Cubit<EditContactState> {
  final ContactRepository _contactRepository;
  EditContactCubit(this._contactRepository) : super(EditContactInitial());

  void editContact(String id, ContactModel contact) {
    emit(EditContactLoading());
    _contactRepository
        .updateContact(id, contact)
        .then((data) => emit(EditContactSuccess()))
        .catchError((e) =>
            emit(EditContactFailure(message: "Update contact error $e")));
  }
}
