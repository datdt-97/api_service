import 'package:dio/dio.dart';

import '../../helpers/http_status.dart';
import '../../helpers/network_request_options.dart';
import '../models/base_api_input.dart';

extension RestRequestOptionExt on BaseAPIInput {
  RequestOptions toRequestOptions([
    NetworkRequestOptions? options,
  ]) =>
      RequestOptions(
        baseUrl: baseUrl,
        method: method.name,
        path: path,
        headers: headers,
        queryParameters: queryParameters,
        data: data,
        connectTimeout: connectTimeout,
        sendTimeout: sendTimeout,
        receiveTimeout: sendTimeout,
        onReceiveProgress: options?.onReceiveProgress,
        validateStatus: (statusCode) => HTTPStatus(statusCode).isOk,
      );
}

extension UploadRequestOptionExt on BaseUploadAPIInput {
  Future<RequestOptions> toRequestOptions([
    NetworkRequestOptions? options,
  ]) async =>
      RequestOptions(
        baseUrl: baseUrl,
        method: method.name,
        path: path,
        headers: headers,
        queryParameters: queryParameters,
        data: await data,
        connectTimeout: connectTimeout,
        sendTimeout: sendTimeout,
        receiveTimeout: sendTimeout,
        onReceiveProgress: options?.onReceiveProgress,
        validateStatus: (statusCode) => HTTPStatus(statusCode).isOk,
        contentType: Headers.multipartFormDataContentType,
      );
}

extension RequestOptionsExt on RequestOptions {
  String get description =>
      'RequestOptions(baseUrl: $baseUrl, method: $method, path: $path, headers: $headers, queryParameters: $queryParameters, data: $data, sendTimeout: $sendTimeout, receiveTimeout: $receiveTimeout)';
}
