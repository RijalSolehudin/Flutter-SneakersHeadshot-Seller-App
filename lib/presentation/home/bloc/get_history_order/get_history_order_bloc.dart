import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/order_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/history_order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_history_order_event.dart';
part 'get_history_order_state.dart';
part 'get_history_order_bloc.freezed.dart';

class GetHistoryOrderBloc
    extends Bloc<GetHistoryOrderEvent, GetHistoryOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  GetHistoryOrderBloc(this.orderRemoteDatasource) : super(const _Initial()) {
    on<_GetHistoryOrder>((event, emit) async {
      emit(const _Loading());
      final result = await orderRemoteDatasource.getHistoryOrder();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });
  }
}
