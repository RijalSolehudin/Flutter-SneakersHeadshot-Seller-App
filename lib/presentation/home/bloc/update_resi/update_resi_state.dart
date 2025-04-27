part of 'update_resi_bloc.dart';

@freezed
class UpdateResiState with _$UpdateResiState {
  const factory UpdateResiState.initial() = _Initial;
  const factory UpdateResiState.loading() = _Loading;
  const factory UpdateResiState.success() = _Success;
  const factory UpdateResiState.error(String message) = _Error;
}
