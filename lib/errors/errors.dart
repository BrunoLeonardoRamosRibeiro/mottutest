abstract class ResultFailure implements Exception {
  final String message;

  ResultFailure(this.message);
}

///
class UfStatesResultFailure extends ResultFailure {
  UfStatesResultFailure({required String message}) : super(message);

  @override
  String toString() {
    return 'UfStatesResultFailure{ message: $message }';
  }
}
