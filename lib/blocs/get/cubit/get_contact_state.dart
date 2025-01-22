part of 'get_contact_cubit.dart';

sealed class GetContactState extends Equatable {
  const GetContactState();

  @override
  List<Object> get props => [];
}

final class GetContactInitial extends GetContactState {}

final class GetContactLoading extends GetContactState {
  final List<ContactModel> contactList;

  const GetContactLoading({this.contactList = const []});

  @override
  List<Object> get props => [contactList];
}

final class GetContactSuccess extends GetContactState {
  final List<ContactModel> contactList;
  final bool isLastpage;

  const GetContactSuccess(
      {required this.contactList, required this.isLastpage});

  @override
  List<Object> get props => [contactList, isLastpage];
}

final class GetContactFailure extends GetContactState {
  final String message;

  const GetContactFailure({required this.message});

  @override
  List<Object> get props => [message];
}
