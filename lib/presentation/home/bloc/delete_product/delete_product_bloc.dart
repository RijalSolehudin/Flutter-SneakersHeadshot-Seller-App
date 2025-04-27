import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';
part 'delete_product_bloc.freezed.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  DeleteProductBloc(this.productRemoteDatasource) : super(const _Initial()) {
    on<_deleteProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productRemoteDatasource.deleteProduct(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
