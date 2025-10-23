import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:random_user_bus_2_teste/app/core/app_constants/app_constants.dart';
import 'package:random_user_bus_2_teste/app/core/exceptions/data_source_exception.dart';
import 'package:random_user_bus_2_teste/app/data/model/random_user_response.dart';

class RestClient {
  late final Dio _dio;

  RestClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.BASE_URL,
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 40),
      ),
    )..interceptors.addAll([LogInterceptor()]);
  }

  Future<List<UserResult>> fetcUser() async {
    try {
      final Response(data: result) = await _dio.get(
        '/',
      );

      final reponseUser = RandomUserResponse.fromJson(result);

      return reponseUser.results;
    } on DioException catch (e, s) {
      var errorMessage = 'Erro ao buscar dados de user';
      log(
        errorMessage,
        error: e,
        stackTrace: s,
        name: 'fetcUser',
      );
      throw DataTableSourceException(message: errorMessage);
    }
  }
}

