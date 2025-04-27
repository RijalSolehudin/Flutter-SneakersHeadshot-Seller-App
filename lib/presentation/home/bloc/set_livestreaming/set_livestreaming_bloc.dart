import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_livestreaming_event.dart';
part 'set_livestreaming_state.dart';
part 'set_livestreaming_bloc.freezed.dart';

class SetLivestreamingBloc
    extends Bloc<SetLivestreamingEvent, SetLivestreamingState> {
  final AuthRemoteDatasource authRemoteDatasource;
  SetLivestreamingBloc(this.authRemoteDatasource) : super(const _Initial()) {
    on<_SetLivestreaming>((event, emit) async {
      emit(const _Loading());
      final result =
          await authRemoteDatasource.setLivestreaming(event.isLivestreaming);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
