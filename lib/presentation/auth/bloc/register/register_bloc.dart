import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/model/request/register_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource authRemoteDatasource;
  RegisterBloc(this.authRemoteDatasource) : super(const _Initial()) {
    on<_register>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDatasource.register(event.data);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded()));
    });
  }
}
