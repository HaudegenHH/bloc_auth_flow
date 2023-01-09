import 'package:bloc_auth_project/auth/auth_repository.dart';
import 'package:bloc_auth_project/auth/form_submission_status.dart';
import 'package:bloc_auth_project/auth/login/login_event.dart';
import 'package:bloc_auth_project/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    // username update
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.login();
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    }
  }
}
