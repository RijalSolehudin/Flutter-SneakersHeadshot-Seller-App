part of 'set_livestreaming_bloc.dart';

@freezed
class SetLivestreamingState with _$SetLivestreamingState {
  const factory SetLivestreamingState.initial() = _Initial;
  const factory SetLivestreamingState.loading() = _Loading;
  const factory SetLivestreamingState.success() = _Success;
  const factory SetLivestreamingState.error(String message) = _Error;
}
