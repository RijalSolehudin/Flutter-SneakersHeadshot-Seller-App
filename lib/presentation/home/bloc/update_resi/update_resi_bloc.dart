import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/order_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_resi_event.dart';
part 'update_resi_state.dart';
part 'update_resi_bloc.freezed.dart';

class UpdateResiBloc extends Bloc<UpdateResiEvent, UpdateResiState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  UpdateResiBloc(this.orderRemoteDatasource) : super(const _Initial()) {
    on<_UpdateResi>((event, emit) async {
      emit(const _Loading());
      final result =
          await orderRemoteDatasource.updateResi(event.orderId, event.resi);
      result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(
                const _Success(),
              ));
    });
  }
}
