part of 'get_agora_token_bloc.dart';

@freezed
class GetAgoraTokenEvent with _$GetAgoraTokenEvent {
  const factory GetAgoraTokenEvent.started() = _Started;
  const factory GetAgoraTokenEvent.getAgoraToken(String channel, String uid) =
      _GetAgoraToken;
}
