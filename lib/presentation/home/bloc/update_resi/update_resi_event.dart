part of 'update_resi_bloc.dart';

@freezed
class UpdateResiEvent with _$UpdateResiEvent {
  const factory UpdateResiEvent.started() = _Started;
  const factory UpdateResiEvent.updateResi(int orderId, String resi) =
      _UpdateResi;
}
