import 'dart:convert';

import 'package:logger/logger.dart';

import 'logger_output.dart';
import 'pretty_log_printer.dart';

abstract final class Log {
  static const _encoder = JsonEncoder.withIndent('  ');
  static void Function(String message) logPrint = print;

  static final _logger = Logger(
    printer: PrettyLogPrinter(),
    output: LoggerOutput(logPrint),
  );

  /// Log a message at level [Level.trace].
  static void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      Level.trace,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.debug].
  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      Level.debug,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.info].
  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      Level.info,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.warning].
  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      Level.warning,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.error].
  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      Level.error,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.fatal].
  static void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      Level.fatal,
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log pretty JSON
  static void json(
    dynamic message, {
    String? tag,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final json = _encoder.convert(message);
    final messageString = tag != null ? '$tag:\n$json' : json;

    _logger.log(
      Level.debug,
      messageString,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
