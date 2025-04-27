import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/login_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Initial()) {
    on<_login>((event, emit) async {
      emit(const _loading());
      final result =
          await AuthRemoteDatasource().login(event.email, event.password);
      result.fold(
        (l) => emit(_error(l)),
        (r) => emit(_success(r)),
      );
    });
  }
}
