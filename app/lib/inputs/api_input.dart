import 'package:md_api_service/api_service.dart';

import '../models/todo.dart';

abstract class APIInput extends BaseRestAPIInput {
  APIInput({
    required super.method,
  });

  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';
}

final class PostTodoAPIInput extends APIInput {
  final Todo todo;

  PostTodoAPIInput({
    required this.todo,
    super.method = HTTPMethod.post,
  });

  @override
  String get path => '/todos';

  @override
  get data => todo.toJson();

  @override
  Params? get queryParameters => {
        'a': 'ab',
      };
}

final class GetTodoListAPIInput extends APIInput {
  GetTodoListAPIInput({
    super.method = HTTPMethod.get,
  });

  @override
  String get path => '/todos';
}
