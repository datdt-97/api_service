import 'package:dio/dio.dart';

import '../../helpers/http_status.dart';
import '../../helpers/network_request_options.dart';
import '../extensions/request_options_ext.dart';
import '../logger/network/network_log_interceptor.dart';
import '../logger/network/network_logger.dart';
import '../models/api_error.dart';
import '../models/api_response.dart';
import '../models/base_api_input.dart';
import '../models/json_array.dart';
import '../models/json_object.dart';
import '../models/type_alias.dart';

abstract base class BaseAPIService {
  BaseAPIService({
    Dio? dio,
    BaseOptions? options,
    List<Interceptor>? interceptors,
    bool isLogEnabled = true,
  }) {
    this.dio = dio ?? Dio(options);
    this.dio.interceptors.addAll([
      if (isLogEnabled) NetworkLogInterceptor(),
      ...?interceptors,
    ]);
  }

  BaseAPIService.init({
    Dio? dio,
    List<Interceptor>? interceptors,
    bool isLogEnabled = true,
  }) : this(
          dio: dio,
          options: BaseOptions(
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
          ),
          interceptors: interceptors,
          isLogEnabled: isLogEnabled,
        );

  BaseAPIService.mock(
    Dio dio, {
    List<Interceptor>? interceptors,
    bool isLogEnabled = true,
  }) : this.init(
          dio: dio,
          interceptors: interceptors,
          isLogEnabled: isLogEnabled,
        );

  late final Dio dio;

  Future<T> requestJSONObject<T>(
    BaseAPIInput input, {
    required T Function(JsonObject jsonObject) mapper,
    NetworkRequestOptions options = const NetworkRequestOptions(),
  }) async {
    final apiResponse = await _requestJSONData<T>(input, options: options);
    return mapper(apiResponse.data as JsonObject? ?? const JsonObject.empty());
  }

  Future<List<T>> requestJSONArray<T>(
    BaseAPIInput input, {
    required T Function(JsonObject jsonObject) mapper,
    NetworkRequestOptions options = const NetworkRequestOptions(),
  }) async {
    final apiResponse =
        await _requestJSONData<List<T>>(input, options: options);
    return (apiResponse.data as JsonArray? ?? const JsonArray.empty())
        .map(mapper)
        .toList();
  }

  Future<APIResponse<JsonData>> _requestJSONData<T>(
    BaseAPIInput input, {
    NetworkRequestOptions options = const NetworkRequestOptions(),
  }) async {
    final preparedInput =
        input.requireAccessToken ? await preprocess(input) : input;

    if (options.isLogEnabled) {
      _logRequest(input, options: options);
    }

    final response = await switch (preparedInput) {
      BaseRestAPIInput() => _makeRestRequest(preparedInput, options: options),
      BaseUploadAPIInput() => _makeUploadRequest(preparedInput),
    };

    return process(response);
  }

  Future<Response> _makeRestRequest(
    BaseAPIInput input, {
    NetworkRequestOptions options = const NetworkRequestOptions(),
  }) async {
    final requestOptions = input.toRequestOptions(options);
    return dio.fetch(requestOptions);
  }

  Future<Response> _makeUploadRequest(BaseUploadAPIInput input) async {
    final formData = await input.data;

    return dio.post(
      input.baseUrl + input.path,
      data: formData,
      options: Options(
        headers: input.headers,
      ),
    );
  }

  Future<BaseAPIInput> preprocess(BaseAPIInput input) {
    return Future.value(input);
  }

  APIResponse<JsonData> process(Response response) {
    Error error;
    final httpStatus = HTTPStatus(response.statusCode);
    JsonData? data;

    final responseData = response.data;

    if (responseData is JSONObjectAlias) {
      data = JsonObject(responseData);
    }

    if (responseData is JSONArrayAlias) {
      final mappedResponseData = responseData
          .map(
            (e) => JsonObject(e),
          )
          .toList();
      data = JsonArray(mappedResponseData);
    }

    if (httpStatus.isOk) {
      return APIResponse<JsonData>(response.headers, data);
    } else {
      error = handleResponseError(response);
    }
    throw error;
  }

  APIResponse<JsonData> handleRequestError(Error error, BaseAPIInput input) {
    throw error;
  }

  Error handleResponseError(Response response) {
    if (response.data is JSONObjectAlias) {
      return handleJSONObjectResponseError(response);
    }

    if (response.data is JSONArrayAlias) {
      return handleJSONArrayResponseError(response);
    }

    return handleResponseUnknownError(response);
  }

  Error handleJSONObjectResponseError(Response response) {
    return APIUnknownError(response.statusCode);
  }

  Error handleJSONArrayResponseError(Response response) {
    return APIUnknownError(response.statusCode);
  }

  Error handleResponseUnknownError(Response response) {
    return APIUnknownError(response.statusCode);
  }

  void _logRequest(
    BaseAPIInput input, {
    NetworkRequestOptions options = const NetworkRequestOptions(),
  }) async {
    final requestOptions = switch (input) {
      BaseRestAPIInput() => input.toRequestOptions(options),
      BaseUploadAPIInput() => await input.toRequestOptions(options),
    };

    if (options.printToCurl) {
      NetworkLogger.renderCurlRepresentation(requestOptions);
    }

    NetworkLogger.logRequest(requestOptions, options.logOptions);
  }
}
