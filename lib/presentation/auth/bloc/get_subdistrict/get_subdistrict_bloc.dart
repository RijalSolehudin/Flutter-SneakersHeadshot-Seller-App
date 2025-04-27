import 'package:bloc/bloc.dart';
import 'package:ecommerce_seller_app/data/datasources/rajaongkir_remote_datasource.dart';
import '../../../../data/model/response/subdistrict_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_subdistrict_event.dart';
part 'get_subdistrict_state.dart';
part 'get_subdistrict_bloc.freezed.dart';

class GetSubdistrictBloc
    extends Bloc<GetSubdistrictEvent, GetSubdistrictState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  GetSubdistrictBloc(this.rajaongkirRemoteDatasource)
      : super(const _Initial()) {
    on<_getSubdistrict>((event, emit) async {
      emit(const _loading());
      final result =
          await rajaongkirRemoteDatasource.getSubdistrict(event.cityId);
      result.fold(
        (l) => emit(_error(l)),
        (r) => emit(_loaded(r.rajaongkir!.results!)),
      );
    });
  }
}
