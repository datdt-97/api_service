import 'package:md_api_service/api_service.dart';

import 'api_service.dart';
import 'inputs/api_input.dart';
import 'models/todo.dart';

void main(List<String> arguments) async {
  Log.logPrint = print;
  final apiService = APIService();

  final postTodoAPIInput = PostTodoAPIInput(todo: Todo(1, 1, 'abc', false));
  try {
    final response = await apiService.requestJSONObject(
      postTodoAPIInput,
      mapper: Todo.fromJson,
      options: NetworkRequestOptions(
        printToCurl: true,
      ),
    );

    Log.json(response);
  } catch (error, stackTrace) {
    Log.e('', time: DateTime.now(), error: error, stackTrace: stackTrace);
  }
}
