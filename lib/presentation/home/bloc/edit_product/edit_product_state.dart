part of 'edit_product_bloc.dart';

@freezed
class EditProductState with _$EditProductState {
  const factory EditProductState.initial() = _Initial;
  const factory EditProductState.loading() = _Loading;
  const factory EditProductState.success() = _Success;
  const factory EditProductState.error(String message) = _Error;
}
