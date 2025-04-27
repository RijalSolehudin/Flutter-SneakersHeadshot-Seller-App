import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/model/response/city_response_model.dart';

part 'get_city_event.dart';
part 'get_city_state.dart';
part 'get_city_bloc.freezed.dart';

class GetCityBloc extends Bloc<GetCityEvent, GetCityState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  GetCityBloc(this.rajaongkirRemoteDatasource) : super(_Initial()) {
    on<_getCity>((event, emit) async {
      emit(const _loading());
      final result = await rajaongkirRemoteDatasource.getCity(event.provinceId);
      result.fold(
        (l) => emit(_error(l)),
        (r) => emit(_loaded(r.rajaongkir!.results!)),
      );
    });
  }
}
