class DataTableSourceException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final int? erroCode;

   DataTableSourceException({this.stackTrace,this.erroCode,required this.message});
}
