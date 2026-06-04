import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../network_info.dart';

class ConnectivityInterceptor extends Interceptor {
  final NetworkInfo networkInfo;

  ConnectivityInterceptor(this.networkInfo);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        ),
      );
    }

    handler.next(options);
  }
}

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final token = '';
    // options.headers['Authorization'] = 'Bearer $token';
    // options.headers['locale'] = sl<LocalizationService>().currentLocale.languageCode;

    super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i(
      '🚀 REQUEST[${options.method}] => ${options.uri}\nHeaders: ${options.headers}\nData: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '✅ RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}\nData: ${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '❌ ERROR[${err.response?.statusCode}] => ${err.requestOptions.uri}\nMessage: ${err.message}\nError: ${err.error}',
    );
    handler.next(err);
  }
}
