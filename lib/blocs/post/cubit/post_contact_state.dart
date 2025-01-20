part of 'post_contact_cubit.dart';

sealed class PostContactState extends Equatable {
  const PostContactState();

  @override
  List<Object> get props => [];
}

final class PostContactInitial extends PostContactState {}

final class PostContactLoading extends PostContactState {}

final class PostContactSuccess extends PostContactState {}

final class PostContactFailure extends PostContactState {
  final String message;
  const PostContactFailure({required this.message});

  @override
  List<Object> get props => [message];
}
