// import 'package:dio/dio.dart';

// extension DioErrorUtils on Object {
//   String get dioErrorMessage {
//     var output = 'Что то пошло не так';
//     if (this is! DioError) return output;
//     final error = this as DioError;
//     final List errorsList = [error.response?.data['message']];
//     if (errorsList == null) return output;
//     if (errorsList.isNotEmpty) {
//       output = errorsList.first.toString();
//     }
//     return output;
//   }

//   int? get dioErrorStatusCode {
//     int? output;
//     if (this is! DioError) return output;
//     return (this as DioError).response?.statusCode;
//   }
// }
