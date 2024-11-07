import 'package:api_service/helpers/http_headers.dart';
import 'package:dio/dio.dart';

import '../helpers/http_method.dart';
import 'type_alias.dart';

sealed class BaseAPIInput {
  BaseAPIInput({
    required this.method,
    this.requireAccessToken = false,
  });

  String get path;
  final HTTPMethod method;
  final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
  final bool requireAccessToken;

  final String? accessToken = null;
  final String? user = null;
  final String? password = null;

  String get baseUrl;

  Params? get queryParameters => null;

  dynamic get data => null;

  Duration get sendTimeout => const Duration(seconds: 30);

  Duration get receiveTimeOut => const Duration(seconds: 30);

  Duration get connectTimeout => const Duration(seconds: 30);

  String get description => [
        '🌎 ${method.name} $baseUrl$path',
        'Headers: ${headers.values}',
        'QueryParameters: ${queryParameters ?? {}}',
        'Body: $data',
      ].join('\n');
}

abstract class BaseRestAPIInput extends BaseAPIInput {
  BaseRestAPIInput({
    required super.method,
    super.requireAccessToken,
  });
}

abstract class BaseUploadAPIInput extends BaseAPIInput {
  final UploadFileAPIData uploadData;

  BaseUploadAPIInput({
    required this.uploadData,
    super.method = HTTPMethod.post,
    super.requireAccessToken,
  });

  @override
  Map<String, dynamic> get headers => super.headers
    ..addHeader(
      const HTTPHeader.contentType('multipart/form-data'),
    );

  @override
  Future<FormData> get data;
}

class UploadFileAPIData {
  final List<MultipartFile> files;

  const UploadFileAPIData({
    required this.files,
  });
}
