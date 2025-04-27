import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/category_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';
part 'add_category_bloc.freezed.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  AddCategoryBloc(this.categoryRemoteDatasource) : super(const _Initial()) {
    on<_AddCategory>((event, emit) async {
      emit(const _Loading());
      final result = await categoryRemoteDatasource.addCategory(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
