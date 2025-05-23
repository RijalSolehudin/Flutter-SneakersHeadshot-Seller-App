part of 'set_livestreaming_bloc.dart';

@freezed
class SetLivestreamingEvent with _$SetLivestreamingEvent {
  const factory SetLivestreamingEvent.started() = _Started;
  const factory SetLivestreamingEvent.setLivestreaming(bool isLivestreaming) =
      _SetLivestreaming;
}
