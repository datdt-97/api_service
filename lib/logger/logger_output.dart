import 'package:logger/logger.dart';

/// Default implementation of [LogOutput].
///
/// It sends everything to the system console.
final class LoggerOutput extends LogOutput {
  final void Function(String message) logPrint;

  LoggerOutput(this.logPrint);

  @override
  void output(OutputEvent event) {
    logPrint(event.lines.join('\n'));
  }
}
