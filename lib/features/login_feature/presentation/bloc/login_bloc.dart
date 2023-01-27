import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ok_task/core/utils/prefs_manager.dart';
import 'package:ok_task/features/login_feature/domain/entities/login_entity.dart';
import 'package:ok_task/features/login_feature/domain/usecases/login_usecase.dart';
import 'package:ok_task/locator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<LoginButtonPressedEvent>(
      (event, emit) async {
        emit(LoginLodingState());

        final token = await loginUsecase.call(Params(login: event.loginEntity));

        token.fold(
          (failure) => emit(const LoginErrorState('Athentication Failed')),
          (right) {
            PrefsManager prefsManager = locator<PrefsManager>();
            prefsManager.setLoggedIn();
            prefsManager.setAccessToken(right);

            emit(LoginSuccessState(right));
          },
        );
      },
    );
  }
}
