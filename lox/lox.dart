import 'dart:io';
import 'dart:convert';
import 'dart:async';

main(List<String> arguments) {
  const int kFilePath = 1;
  if (arguments.length > 1) {
    print("Usage: jlox [script]");
  } else if (arguments.length == kFilePath) {
    runFile(arguments[kFilePath]);
  } else {
    runPrompt();
  }
}

void runFile(final String path) {
  final file = new File(path);
  Stream<List<int>> inputStream = file.openRead();
  run(inputStream);
}

Future<int> runPrompt() async {
  while (true) {
    await run(stdin);
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
