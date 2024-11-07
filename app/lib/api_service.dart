import 'package:api_service/api_service.dart';

final class APIService extends BaseAPIService {
  APIService() : super.init();

  @override
  Future<BaseAPIInput> preprocess(BaseAPIInput input) async {
    input.headers.addHeader(
      HTTPHeader.bearerAuthorization('bearerToken'),
    );
    return input;
  }
}
