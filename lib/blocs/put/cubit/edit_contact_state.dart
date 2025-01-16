part of 'edit_contact_cubit.dart';

sealed class EditContactState extends Equatable {
  const EditContactState();

  @override
  List<Object> get props => [];
}

final class EditContactInitial extends EditContactState {}
