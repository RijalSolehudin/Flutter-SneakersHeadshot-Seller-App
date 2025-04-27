part of 'get_city_bloc.dart';

@freezed
class GetCityState with _$GetCityState {
  const factory GetCityState.initial() = _Initial;
  const factory GetCityState.loading() = _loading;
  const factory GetCityState.loaded(List<City> result) = _loaded;
  const factory GetCityState.error(String message) = _error;
}
