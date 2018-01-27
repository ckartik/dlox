import 'token_types.dart';

class Token {
  Object get literal => _literal;
  String get lexeme => _lexeme;
  TokenTypes get type => _type;
  int get line => _line;
  final Object _literal;
  final String _lexeme;
  final TokenTypes _type;
  final int _line;

  Token(TokenTypes type, String lexeme, Object literal, int line)
      : _type = type,
        _lexeme = lexeme,
        _literal = literal,
        _line = line;

  String toString() => type.toString() + " " + lexeme + " " + literal;
}
