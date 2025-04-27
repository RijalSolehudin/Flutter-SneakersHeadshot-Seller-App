import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/agora_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_agora_token_event.dart';
part 'get_agora_token_state.dart';
part 'get_agora_token_bloc.freezed.dart';

class GetAgoraTokenBloc extends Bloc<GetAgoraTokenEvent, GetAgoraTokenState> {
  final AgoraRemoteDatasource agoraRemoteDatasource;
  GetAgoraTokenBloc(this.agoraRemoteDatasource) : super(const _Initial()) {
    on<_GetAgoraToken>((event, emit) async {
      emit(const _Loading());
      final result =
          await agoraRemoteDatasource.getAgoraToken(event.channel, event.uid);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(event.channel, event.uid, r)),
      );
    });
  }
}
