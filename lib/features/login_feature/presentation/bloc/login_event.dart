part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends LoginEvent {
  final LoginEntity loginEntity;

  const LoginButtonPressedEvent(this.loginEntity);

  @override
  List<Object> get props => [loginEntity];
}
