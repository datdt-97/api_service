enum LogOption {
  request(1 << 0),
  requestHeaders(1 << 1),
  requestParameters(1 << 2),
  requestBody(1 << 3),
  rawRequest(1 << 4),
  urlResponse(1 << 5),
  responseStatus(1 << 6),
  responseHeaders(1 << 7),
  responseData(1 << 8),
  error(1 << 9),
  cache(1 << 10);

  const LogOption(this.value);

  final int value;
}

const List<LogOption> defaultLogOptions = [
  LogOption.request,
  LogOption.requestHeaders,
  LogOption.requestParameters,
  LogOption.requestBody,
  LogOption.responseStatus,
  LogOption.responseHeaders,
  LogOption.responseData,
  LogOption.error
];

const List<LogOption> noneOfLogOptions = [];

const List<LogOption> allOfLogOptions = [
  LogOption.request,
  LogOption.requestHeaders,
  LogOption.requestParameters,
  LogOption.requestBody,
  LogOption.rawRequest,
  LogOption.urlResponse,
  LogOption.responseStatus,
  LogOption.responseHeaders,
  LogOption.responseData,
  LogOption.error,
  LogOption.cache
];
