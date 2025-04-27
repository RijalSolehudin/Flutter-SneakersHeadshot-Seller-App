import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_products_event.dart';
part 'get_all_products_state.dart';
part 'get_all_products_bloc.freezed.dart';

class GetAllProductsBloc
    extends Bloc<GetAllProductsEvent, GetAllProductsState> {
  GetAllProductsBloc() : super(const _Initial()) {
    on<_GetProducts>((event, emit) async {
      emit(const _Loading());
      final result = await ProductRemoteDatasource().getProducts();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data!)),
      );
    });
  }
}
