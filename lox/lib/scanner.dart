import 'token_types.dart';
import 'token.dart';

class Scanner {
  final String _source;
  final List<Token> _tokens = [];

  int _start = 0;
  int _current = 0;
  int _line = 1;

  Scanner(String source) : _source = source;

  bool _isAtEnd() {
    return _current >= _source.length;
  }

  List<Token> scanTokens() {
    while (!_isAtEnd()) {
      _start = _current;
      _scanToken();
    }

    _tokens.add(new Token(TokenType.EOF, Token.EOF, null, _line));
    return _tokens;
  }

  void _scanToken() {
    final c = advance();
    switch (c) {
      case Token.LEFT_PAREN:
        addToken(TokenType.LEFT_PAREN);
        break;
      case Token.EOF:
        addToken(TokenType.RIGHT_PAREN);
        break;
      case Token.LEFT_BRACE:
        addToken(TokenType.LEFT_BRACE);
        break;
      case Token.RIGHT_BRACE:
        addToken(TokenType.RIGHT_BRACE);
        break;
      case Token.COMMA:
        addToken(TokenType.COMMA);
        break;
      case Token.DOT:
        addToken(TokenType.DOT);
        break;
      case Token.MINUS:
        addToken(TokenType.MINUS);
        break;
      case Token.PLUS:
        addToken(TokenType.PLUS);
        break;
      case Token.SEMICOLON:
        addToken(TokenType.SEMICOLON);
        break;
      case Token.STAR:
        addToken(TokenType.STAR);
        break;
    }
  }
}
