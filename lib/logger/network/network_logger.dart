import 'dart:convert';

import 'package:dio/dio.dart';

import '../../helpers/http_method.dart';
import '../log.dart';
import 'log_options.dart';

enum _BodyType {
  formData,
  file,
  json;
}

abstract final class NetworkLogger {
  static const _jsonEncoder = JsonEncoder.withIndent('  ');

  static void renderCurlRepresentation(RequestOptions requestOptions) {
    // add a breakpoint here so all errors can break
    try {
      Log.d(cURLRepresentation(requestOptions));
    } catch (err) {
      Log.e('unable to create a CURL representation of the requestOptions');
    }
  }

  static String cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != HTTPMethod.get.name) {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData) {
        options.data = Map.fromEntries((options.data as FormData).fields);
      }

      final data = const JsonEncoder.withIndent('   ')
          .convert(options.data)
          .replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }

  static void logRequest(
    RequestOptions requestOptions,
    List<LogOption> logOptions,
  ) {
    final messageBuffer = StringBuffer(
      '🌎 Request ║ ${requestOptions.method}\n',
    );
    messageBuffer.writeln(requestOptions.uri);
    messageBuffer.writeln();

    if (logOptions.contains(LogOption.requestHeaders)) {
      final requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(requestOptions.headers);
      requestHeaders['responseType'] = requestOptions.responseType.toString();
      requestHeaders['followRedirects'] = requestOptions.followRedirects;
      requestHeaders['connectTimeout'] =
          requestOptions.connectTimeout?.toString();
      requestHeaders['receiveTimeout'] =
          requestOptions.receiveTimeout?.toString();

      messageBuffer.writeln(_getFromMap(requestHeaders, header: 'Headers:'));
    }

    if (logOptions.contains(LogOption.requestParameters) &&
        requestOptions.queryParameters.isNotEmpty) {
      messageBuffer.writeln('Query Parameters:');
      messageBuffer.writeln(
        _jsonEncoder.convert(requestOptions.queryParameters),
      );
      messageBuffer.writeln();
    }

    if (logOptions.contains(LogOption.requestBody) &&
        requestOptions.method != HTTPMethod.get.name) {
      messageBuffer.writeln(
        _getBody(
          key: 'Request Body',
          value: requestOptions.data,
        ),
      );
    }

    Log.d(messageBuffer);
  }

  static void logResponse(
    Response response,
    List<LogOption> logOptions,
  ) {
    final method = response.requestOptions.method;
    final uri = response.requestOptions.uri;
    final messageBuffer = StringBuffer(
      '👍 Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}\n',
    );
    messageBuffer.writeln(uri);
    messageBuffer.writeln();

    if (logOptions.contains(LogOption.responseHeaders)) {
      final requestHeaders = response.headers.map;
      messageBuffer.writeln(_getFromMap(requestHeaders, header: 'Headers:'));
    }

    if (logOptions.contains(LogOption.responseData)) {
      messageBuffer.writeln(
        _getBody(
          key: 'Response Body:',
          value: response.data,
          isResponse: true,
        ),
      );
    }

    Log.d(messageBuffer);
  }

  static void logError(
    DioException error,
    List<LogOption> logOptions,
  ) {
    final messageBuffer = StringBuffer();

    if (error.type == DioExceptionType.badResponse) {
      final uri = error.response?.requestOptions.uri;
      messageBuffer.writeln(
        '❌ DioError ║ Status: ${error.response?.statusCode} ${error.response?.statusMessage}',
      );
      messageBuffer.writeln(uri);

      if (error.response != null && error.response?.data != null) {
        messageBuffer.writeln(
          _getBody(
            key: '${error.type.toString()}:',
            value: error.response?.data,
            isResponse: true,
          ),
        );
      }
    }

    Log.e(messageBuffer);
  }

  static String _getFromMap(
    Map<String, dynamic> data, {
    String? header,
  }) {
    final messageBuffer = StringBuffer();
    messageBuffer.writeln(header ?? '');
    final dataStr = data.entries
        .map(
          (entry) =>
              '\t${entry.key}: ${(entry.value is List && entry.value.length == 1) ? '[${(entry.value).join(', ')}]' : entry.value.toString()}',
        )
        .join('\n');
    messageBuffer.writeln(dataStr);
    messageBuffer.writeln();
    return messageBuffer.toString();
  }

  static String _getBody({
    required String key,
    dynamic value,
    bool isResponse = false,
  }) {
    final messageBuffer = StringBuffer();
    final type = _getBodyType(value);
    final isValueNull = value == null;

    final encodedJson = switch (type) {
      _BodyType.formData => _jsonEncoder.convert(
          Map.fromEntries((value as FormData).fields),
        ),
      _BodyType.file => 'File: ${value.runtimeType.toString()}',
      _BodyType.json => _jsonEncoder.convert(value),
    };

    final messageKey = switch (type) {
      _BodyType.formData when !isResponse => '[FormData.fields] $key',
      _BodyType.file when !isResponse => '[File] $key',
      _BodyType.json when !isValueNull && !isResponse => '[Json] $key',
      _ => key,
    };

    messageBuffer.writeln('$messageKey\n$encodedJson');

    if (type == _BodyType.formData && !isResponse) {
      final files = (value as FormData)
          .files
          .map((e) => e.value.filename ?? 'Null or Empty filename')
          .toList();
      if (files.isNotEmpty) {
        final encodedJson = _jsonEncoder.convert(files);
        messageBuffer.writeln('[FormData.files] Request Body:\n$encodedJson');
      }
    }

    return messageBuffer.toString();
  }

  static _BodyType _getBodyType(dynamic value) {
    return switch (value.runtimeType) {
      FormData _ => _BodyType.formData,
      ResponseBody _ => _BodyType.file,
      _ => _BodyType.json,
    };
  }
}
