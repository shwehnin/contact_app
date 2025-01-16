import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  GetContactCubit() : super(GetContactInitial());
}
