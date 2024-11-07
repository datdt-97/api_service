import 'package:dio/dio.dart';

final class APIResponse<T> {
  APIResponse(this.header, this.data);

  final Headers? header;
  final T? data;
}
