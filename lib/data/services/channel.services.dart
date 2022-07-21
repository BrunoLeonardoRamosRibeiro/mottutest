import 'package:flutter/services.dart';

class Channel {
  final MethodChannel _methodChannel = MethodChannel('boasvendas.com/estados');
  final MethodChannel _methodChannelBattery =
      MethodChannel('boasvendas.com/battery');

  Future<String> getAll() async {
    try {
      final result = await _methodChannel.invokeMethod('getAll');
      return result;
    } catch (e) {
      throw Exception('Aconteceu um erro e não consegui buscar os dados');
    }
  }

  Future<String> getBatterylevel() async {
    final result = await _methodChannelBattery.invokeMethod('getBatteryLevel');
    return result;
  }
}
