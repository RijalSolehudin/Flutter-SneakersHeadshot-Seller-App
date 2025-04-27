import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/model/request/add_product_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';
part 'add_product_bloc.freezed.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  AddProductBloc(this.productRemoteDatasource) : super(const _Initial()) {
    on<_addProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productRemoteDatasource.addProduct(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          emit(const _Success());
          print(r.message);
        },
      );
    });
  }
}
