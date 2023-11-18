part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddUpdateDeletePostState extends AddUpdateDeletePostState {}

class ErrorAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;

  ErrorAddUpdateDeletePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;

  MessageAddUpdateDeletePostState({required this.message});

  @override
  List<Object> get props => [message];
}