import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/category_remote_datasource.dart';
import 'package:ecommerce_seller_app/data/model/response/categories_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';
part 'get_categories_bloc.freezed.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  GetCategoriesBloc(this.categoryRemoteDatasource) : super(const _Initial()) {
    on<_GetCategories>((event, emit) async {
      emit(const _Loading());
      final result = await categoryRemoteDatasource.getCategories();
      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          emit(_Loaded(r.data!));
        },
      );
    });
  }
}
