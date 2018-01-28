import 'dart:io';
import 'dart:convert';
import 'dart:async';

import '../lib/error_module.dart';

class Lox {
  static bool hadError = false;
  void runFile(final String path) {
    final file = new File(path);
    Stream<List<int>> inputStream = file.openRead();
    run(inputStream);
    if (hadError) exit(65);
  }

  Future<int> runPrompt() async {
    while (true) {
      await run(stdin);
      hadError = false;
    }
    return 0;
  }

  Future<int> run(final Stream stream) async {
    stream.transform(UTF8.decoder);
    // For now just going to print the decoded stream.
    await for (var values in stream) {
      stdout.write("> ");
      print(values.toString());
    }
    return 0;
  }

  static void error(int line, String err) {
    ErrorReporter.report(line, "", err);
    hadError = true;
  }
}

main(List<String> arguments) {
  const int kFilePath = 1;
  if (arguments.length > 1) {
    print("Usage: jlox [script]");
  } else if (arguments.length == kFilePath) {
    Lox lox = new Lox();
    lox.runFile(arguments[kFilePath]);
  } else {
    Lox lox = new Lox();
    lox.runPrompt();
  }
}
