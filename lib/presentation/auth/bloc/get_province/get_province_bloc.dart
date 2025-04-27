import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/rajaongkir_remote_datasource.dart';
import '../../../../data/model/response/province_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_province_event.dart';
part 'get_province_state.dart';
part 'get_province_bloc.freezed.dart';

class GetProvinceBloc extends Bloc<GetProvinceEvent, GetProvinceState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  GetProvinceBloc(this.rajaongkirRemoteDatasource) : super(_Initial()) {
    on<GetProvinceEvent>((event, emit) async {
      emit(const _loading());
      final result = await rajaongkirRemoteDatasource.getProvince();
      result.fold((l) => emit(const _error()),
          (r) => emit(_loaded(r.rajaongkir!.results!)));
    });
  }
}
