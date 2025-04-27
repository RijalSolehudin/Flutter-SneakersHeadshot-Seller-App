part of 'get_agora_token_bloc.dart';

@freezed
class GetAgoraTokenState with _$GetAgoraTokenState {
  const factory GetAgoraTokenState.initial() = _Initial;
  const factory GetAgoraTokenState.loading() = _Loading;
  const factory GetAgoraTokenState.loaded(
      String channel, String uid, String token) = _Loaded;
  const factory GetAgoraTokenState.error(String message) = _Error;
}
