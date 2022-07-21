// ignore_for_file: prefer_final_fields, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:mottu/data/models/models/estado.model.dart';
import 'package:mottu/data/services/channel.services.dart';
import 'package:mottu/domain/usecases/get_all_states.usecase.dart';
import 'package:mottu/shared/utils.dart';

class HomeController extends GetxController {
  final IGetAllStates usecase;

  HomeController({required this.usecase});

  final Channel _channel = Channel();

  RxList<Estado> _ufStates = <Estado>[].obs;

  List<Estado> get ufStates => _ufStates.value;

  set ufStates(List<Estado> value) {
    _ufStates.value = value;
  }

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) {
    _isLoading.value = value;
  }

  RxString _batteryLevel = 'Aguardando...'.obs;

  String get batteryLevel => _batteryLevel.value;

  set batteryLevel(String value) {
    _batteryLevel.value = value;
  }

  Future<void> getAll() async {
    isLoading = true;

    var result = await usecase();

    result.fold((fail) {
      showError(error: 'Não consegui acessar a API!', message: fail.message);
    }, (items) {
      ufStates.clear();
      ufStates.assignAll(items);
    });
    getBatteryLevel();
    isLoading = false;
  }

  @override
  void onReady() {
    super.onReady();
    getBatteryLevel();
  }

  void getBatteryLevel() async {
    batteryLevel = await _channel.getBatterylevel();
  }
}
