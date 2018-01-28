import 'dart:io';

class ErrorReporter {
  static void report(int line, String where, String msg) {
    stderr.writeln("Line: " + line.toString() + " Error " + where + ": " + msg);
  }
}
