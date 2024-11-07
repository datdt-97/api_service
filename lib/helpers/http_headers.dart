
import 'dart:convert';

final class HTTPHeader {
  const HTTPHeader(this.name, this.value);

  const HTTPHeader.accept(this.value) : name = 'Accept';

  const HTTPHeader.acceptCharset(this.value) : name = 'Accept-Charset';

  const HTTPHeader.acceptLanguage(this.value) : name = 'Accept-Language';

  const HTTPHeader.acceptEncoding(this.value) : name = 'Accept-Encoding';

  const HTTPHeader.authorization(this.value) : name = 'Authorization';

  const HTTPHeader.contentDisposition(this.value)
      : name = 'Content-Disposition';

  const HTTPHeader.contentType(this.value) : name = 'Content-Type';

  const HTTPHeader.userAgent(this.value) : name = 'User-Agent';

  final String name;
  final String value;

  static HTTPHeader basicAuthorization(String username, String password) {
    final credential = '$username:$password';
    final bytes = utf8.encode(credential);
    final base64String = base64.encode(bytes);
    return HTTPHeader.authorization(base64String);
  }

  static HTTPHeader bearerAuthorization(String bearerToken) {
    return HTTPHeader.authorization('Bearer $bearerToken');
  }

  @override
  String toString() => '$name: $value';
}

extension HeaderExt on Map<String, dynamic> {
  void addHeader(HTTPHeader header) {
    this[header.name] = header.value;
  }

  void addAllHeaders(List<HTTPHeader> headers) {
    for (final header in headers) {
      addHeader(header);
    }
  }
}
