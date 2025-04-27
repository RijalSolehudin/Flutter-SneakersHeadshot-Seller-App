part of 'get_history_order_bloc.dart';

@freezed
class GetHistoryOrderEvent with _$GetHistoryOrderEvent {
  const factory GetHistoryOrderEvent.started() = _Started;
  const factory GetHistoryOrderEvent.getHistoryOrder() = _GetHistoryOrder;
}
