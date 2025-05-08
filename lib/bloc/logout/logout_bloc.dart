import 'package:bloc/bloc.dart';
import 'package:flutter_siakad_app/data/datasources/auth_remote_datasources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(_Initial()) {
    on<_Logout>((event, emit) async {
      emit(const LogoutState.loading());
      final response = await AuthRemoteDatasources().logout();

      response.fold(
        (error) {
          emit(_Error());
        },
        (data) async {
          emit(_Loaded());
        },
      );
    });
  }
}
