import 'package:dartz/dartz.dart';
import 'package:mottu/data/datasources/uf_states.datasource.dart';
import 'package:mottu/data/models/models/estado.model.dart';
import 'package:mottu/domain/repositories/uf_state.contract.repository.dart';
import 'package:mottu/errors/errors.dart';

class UfStatesRepository implements IUfStatesRepository {
  final IUfStatesDatasource _datasource;

  UfStatesRepository(this._datasource);

  @override
  Future<Either<ResultFailure, List<Estado>>> getAll() async {
    try {
      return Right(await _datasource.getAll());
    } catch (e) {
      return Left(UfStatesResultFailure(message: e.toString()));
    }
  }
}
