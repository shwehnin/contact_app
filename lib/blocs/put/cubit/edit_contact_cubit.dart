import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_contact_state.dart';

class EditContactCubit extends Cubit<EditContactState> {
  EditContactCubit() : super(EditContactInitial());
}
