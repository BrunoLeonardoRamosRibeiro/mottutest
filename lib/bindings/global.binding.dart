import 'package:get/get.dart';
import 'package:mottu/data/datasources/uf_states.datasource.dart';
import 'package:mottu/data/repositories/uf_states.repository.dart';
import 'package:mottu/data/services/channel.services.dart';
import 'package:mottu/domain/usecases/get_all_states.usecase.dart';

class GlobalBindings implements Bindings {
  @override
  void dependencies() {
    /// Datasources
    Get.lazyPut(() => UfStatesDatasource(Channel()));

    /// Repositories
    Get.lazyPut(() => UfStatesRepository(Get.find<UfStatesDatasource>()));

    /// Usecases
    Get.put(GetAllStates(Get.find<UfStatesRepository>()), permanent: true);
  }
}
