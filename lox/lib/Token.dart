import 'token_types.dart';

class Token {
  static const LEFT_PAREN = '(';
  static const RIGHT_PAREN = ')';
  static const LEFT_BRACE = '{';
  static const RIGHT_BRACE = '}';
  static const COMMA = ',';
  static const DOT = '.';
  static const MINUS = '-';
  static const PLUS = '+';
  static const SEMICOLON = ';';
  static const STAR = '*';
  static const EOF = '';

  Object get literal => _literal;
  String get lexeme => _lexeme;
  TokenType get type => _type;
  int get line => _line;
  final Object _literal;
  final String _lexeme;
  final TokenType _type;
  final int _line;

  Token(TokenType type, String lexeme, Object literal, int line)
      : _type = type,
        _lexeme = lexeme,
        _literal = literal,
        _line = line;

  String toString() => type.toString() + " " + lexeme + " " + literal;
}
