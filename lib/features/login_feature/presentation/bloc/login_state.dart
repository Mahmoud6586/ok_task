part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLodingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final String token;
  const LoginSuccessState(this.token);
  @override
  List<Object> get props => [token];
}

class LoginErrorState extends LoginState {
  final String message;
  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}
