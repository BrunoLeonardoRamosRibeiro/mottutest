import 'dart:convert';
import 'package:mottu/data/models/models/estado.model.dart';
import 'package:mottu/data/services/channel.services.dart';

abstract class IUfStatesDatasource {
  Future<List<Estado>> getAll();
}

class UfStatesDatasource implements IUfStatesDatasource {
  final Channel _channel;

  UfStatesDatasource(this._channel);

  @override
  Future<List<Estado>> getAll() async {
    try {
      List<Estado> ufList;
      var result = await _channel.getAll();
      Iterable list = jsonDecode(result);
      ufList = list.map((model) => Estado.fromJson(model)).toList();
      return ufList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
