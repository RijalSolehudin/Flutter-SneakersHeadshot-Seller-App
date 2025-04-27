import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/model/request/edit_product_request_model.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';
part 'edit_product_bloc.freezed.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  EditProductBloc(this.productRemoteDatasource) : super(const _Initial()) {
    on<_EditProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productRemoteDatasource.editProduct(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
