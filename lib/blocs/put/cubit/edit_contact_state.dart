part of 'edit_contact_cubit.dart';

sealed class EditContactState extends Equatable {
  const EditContactState();

  @override
  List<Object> get props => [];
}

final class EditContactInitial extends EditContactState {}

final class EditContactLoading extends EditContactState {}

final class EditContactSuccess extends EditContactState {}

final class EditContactFailure extends EditContactState {
  final String message;
  const EditContactFailure({required this.message});
  @override
  List<Object> get props => [message];
}
