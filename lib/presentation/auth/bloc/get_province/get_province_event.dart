part of 'get_province_bloc.dart';

@freezed
class GetProvinceEvent with _$GetProvinceEvent {
  const factory GetProvinceEvent.started() = _Started;
  const factory GetProvinceEvent.GetProvince() = _GetProvince;
}
