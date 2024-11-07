import 'package:dio/dio.dart';

import 'log_options.dart';
import 'network_logger.dart';

/// A simple dio log interceptor (mainly inspired by the built-in dio
/// `LogInterceptor`), which has coloring features and json formatting
/// so you can have a better readable output.
class NetworkLogInterceptor extends Interceptor {
  final List<LogOption> logOptions;

  NetworkLogInterceptor({
    this.logOptions = defaultLogOptions,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (logOptions.contains(LogOption.error)) {
      NetworkLogger.logError(err, logOptions);
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    NetworkLogger.logResponse(response, logOptions);
    super.onResponse(response, handler);
  }
}
