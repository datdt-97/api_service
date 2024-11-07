// /// HTTP methods.
enum HTTPMethod {
  /// The [get] method requests a representation of the specified resource.
  /// Requests using [get] should only retrieve data.
  get._('GET'),

  /// The [head] method asks for a response identical to that of a [get] request,
  /// but without the response body.
  head._('HEAD'),

  /// The [post] method is used to submit an entity to the specified resource,
  /// often causing a change in state or side effects on the server.
  post._('POST'),

  /// The [put] method replaces all current representations of the
  /// target resource with the request payload.
  put._('PUT'),

  /// The [delete] method deletes the specified resource.
  delete._('DELETE'),

  /// The [patch] method is used to apply partial modifications to a resource.
  patch._('PATCH');

  const HTTPMethod._(this.name);

  final String name;

  /// Taken from [BaseOptions]. The default methods that are considered
  /// to have a payload. Only for these methods a default content-type header is
  /// added, if no specified.
  static const allowedPayloadMethods = [post, put, patch, delete];

  static const all = [get, head, post, put, patch, delete];

  bool get isAllowedPayloadMethod => allowedPayloadMethods.contains(this);
}
