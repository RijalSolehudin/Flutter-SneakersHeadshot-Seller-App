part of 'get_subdistrict_bloc.dart';

@freezed
class GetSubdistrictState with _$GetSubdistrictState {
  const factory GetSubdistrictState.initial() = _Initial;
  const factory GetSubdistrictState.loading() = _loading;
  const factory GetSubdistrictState.loaded(List<Subdistrict> kecamatan) =
      _loaded;
  const factory GetSubdistrictState.error(String message) = _error;
}
