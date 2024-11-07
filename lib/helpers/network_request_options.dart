import '../logger/network/log_options.dart';

final class NetworkRequestOptions {
  const NetworkRequestOptions({
    this.isLogEnabled = true,
    this.printToCurl = false,
    this.ignoreLogOptions = const [],
    this.onReceiveProgress,
  });

  final bool isLogEnabled;
  final bool printToCurl;
  final List<LogOption> _logOptions = defaultLogOptions;
  final List<LogOption> ignoreLogOptions;

  final void Function(int, int)? onReceiveProgress;

  List<LogOption> get logOptions =>
      _logOptions.toSet().difference(ignoreLogOptions.toSet()).toList();
}
