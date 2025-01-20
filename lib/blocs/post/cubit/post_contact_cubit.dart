import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:contact_app/repo/contact_repository.dart';
import 'package:contact_app/data/models/contact_model.dart';

part 'post_contact_state.dart';

class PostContactCubit extends Cubit<PostContactState> {
  final ContactRepository _contactRepository;
  PostContactCubit(this._contactRepository) : super(PostContactInitial());

  void postContact(ContactModel contact) {
    emit(PostContactLoading());
    _contactRepository
        .addContact(contact)
        .then((data) => emit(PostContactSuccess()))
        .catchError((e) => "Add Contact Error $e");
  }
}
