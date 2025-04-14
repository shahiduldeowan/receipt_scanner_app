// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:receipt_scanner_app/controllers/cubit/receipt_cubit_cubit.dart'
    as _i908;
import 'package:receipt_scanner_app/services/camera_service.dart' as _i304;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i908.ReceiptCubit>(() => _i908.ReceiptCubit());
    gh.lazySingleton<_i304.CameraService>(() => _i304.CameraService());
    return this;
  }
}
