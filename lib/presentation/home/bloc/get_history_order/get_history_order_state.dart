part of 'get_history_order_bloc.dart';

@freezed
class GetHistoryOrderState with _$GetHistoryOrderState {
  const factory GetHistoryOrderState.initial() = _Initial;
  const factory GetHistoryOrderState.loading() = _Loading;
  const factory GetHistoryOrderState.loaded(List<HistoryOrder> data) = _Loaded;
  const factory GetHistoryOrderState.error(String message) = _Error;
}
