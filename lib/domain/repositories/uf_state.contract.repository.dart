import 'package:mottu/data/models/models/estado.model.dart';
import 'package:dartz/dartz.dart';
import 'package:mottu/errors/errors.dart';

abstract class IUfStatesRepository {
  Future<Either<ResultFailure, List<Estado>>> getAll();
}