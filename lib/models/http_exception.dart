
class HttpException implements Exception{
  final String error;

  HttpException(this.error);

  @override
  String toString() {
    // TODO: implement toString
    return error;
  }
}