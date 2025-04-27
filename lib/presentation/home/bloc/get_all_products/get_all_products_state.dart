part of 'get_all_products_bloc.dart';

@freezed
class GetAllProductsState with _$GetAllProductsState {
  const factory GetAllProductsState.initial() = _Initial;
  const factory GetAllProductsState.loading() = _Loading;
  const factory GetAllProductsState.success(List<Products> data) = _Success;
  const factory GetAllProductsState.error(String message) = _Error;
}
