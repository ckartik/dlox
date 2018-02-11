import 'token_types.dart';

class Token {

  static const leftParen = '(';
  static const rightParen = ')';
  static const leftBrace = '{';
  static const rightBrace = '}';
  static const comma = ',';
  static const dot = '.';
  static const minus = '-';
  static const plus = '+';
  static const semicolon = ';';
  static const star = '*';
  static const eof = '';
  static const bang = '!';
  static const equal = '=';
  static const greater= '>';
  static const less = '<';
  static const slash = '/';
  static const new_line = '\n';
  static const space = ' ';
  static const spaceR = '\r';
  static const spaceTab = '\t';
  static const string = '"';

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
