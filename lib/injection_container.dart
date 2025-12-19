import 'package:get_it/get_it.dart';
import 'features/outlier_detection/domain/services/outlier_service.dart';
import 'features/outlier_detection/domain/usecases/outlier_detection_usecase.dart';
import 'features/outlier_detection/presentation/viewmodels/main_view_model.dart';

final sl = GetIt.instance; 

void setupDependencies() {
  sl.registerLazySingleton(() => OutlierService());
  sl.registerLazySingleton(() => OutlierDetectionUseCase());
  sl.registerFactory(() => MainViewModel(useCase: sl()));
}