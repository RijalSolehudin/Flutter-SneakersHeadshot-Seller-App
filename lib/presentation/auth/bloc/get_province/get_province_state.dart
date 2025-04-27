part of 'get_province_bloc.dart';

@freezed
class GetProvinceState with _$GetProvinceState {
  const factory GetProvinceState.initial() = _Initial;
  const factory GetProvinceState.loading() = _loading;
  const factory GetProvinceState.loaded(List<Province> results) = _loaded;
  const factory GetProvinceState.error() = _error;
}
