import 'package:dartz/dartz.dart';
import 'package:mottu/data/models/models/estado.model.dart';
import 'package:mottu/domain/repositories/uf_state.contract.repository.dart';
import 'package:mottu/errors/errors.dart';

abstract class IGetAllStates {
  Future<Either<ResultFailure, List<Estado>>> call();
}

class GetAllStates implements IGetAllStates {
  final IUfStatesRepository _repository;

  GetAllStates(this._repository);

  @override
  Future<Either<ResultFailure, List<Estado>>> call() async {
    return await _repository.getAll();
  }
}
