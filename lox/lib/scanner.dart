import 'token_types.dart';
import 'token.dart';
import '../src/lox.dart';
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

    _tokens.add(new Token(TokenType.eof, Token.eof, null, _line));
    return _tokens;
  }

  String advance() {
    _current++;
    return _source[_current - 1];
  }

  void addToken(TokenType type, [Object literal]) {
    final text = _source.substring(_start, _current);
    _tokens.add(new Token(type, text, literal, _line));
  }

  void _scanToken() {
    final c = advance();
    switch (c) {
      case Token.leftParen:
        addToken(TokenType.leftParen);
        break;
      case Token.eof:
        addToken(TokenType.rightParen);
        break;
      case Token.leftBrace:
        addToken(TokenType.leftBrace);
        break;
      case Token.rightBrace:
        addToken(TokenType.rightBrace);
        break;
      case Token.comma:
        addToken(TokenType.comma);
        break;
      case Token.dot:
        addToken(TokenType.dot);
        break;
      case Token.minus:
        addToken(TokenType.minus);
        break;
      case Token.plus:
        addToken(TokenType.plus);
        break;
      case Token.semicolon:
        addToken(TokenType.semicolon);
        break;
      case Token.star:
        addToken(TokenType.star);
        break;
      case Token.bang:
        addToken(_match(Token.equal) ? TokenType.bangEqual : TokenType.bang);
        break;
      case Token.greater:
        addToken(_match(Token.equal) ? TokenType.greaterEqual : TokenType.greater);
        break;
      case Token.less:
        addToken(_match(Token.equal) ? TokenType.lessEqual: TokenType.less);
        break;
      case Token.equal:
        addToken(_match(Token.equal) ? TokenType.equalEqual : TokenType.equal);
        break;
      case Token.slash:
        if(_match(Token.slash)){
          while (_peek() != Token.new_line && !_isAtEnd()) advance();
        }
        else addToken(TokenType.slash);
        break;
      case Token.new_line:
        _line++;
        break;
      case Token.space:
        break;
      case Token.spaceR:
        break;
      case Token.spaceTab:
        break;
      case Token.string:
        _string();
        break;
      default:
        if(isDigit(c)){
          _number();
    } else {
          Lox.error(_line, "Unexpected character.");
        }
        break;
    }
  }

  // TODO(ckartik): Test as this may be a source of headache.
  bool isDigit(c) => (c >= '0' && c <= '9');

  void _number() {
    while (isDigit(_peek())) advance();

    // Look for a fractional part.
    if (_peek() == '.' && isDigit(_peekNext())) {
      // Consume the "."
      advance();

      while (isDigit(_peek())) advance();
    }

    addToken(TokenType.number,
        double.parse(_source.substring(_start, _current)));
  }

  void _string(){
    while (_peek() != Token.string && !_isAtEnd()) {
      if (_peek() == Token.new_line) _line++;
      advance();
    }

    // Unterminated string.
    if (_isAtEnd()) {
      Lox.error(_line, "Unterminated string.");
      return;
    }

    // The closing ".
    advance();

    // Trim the surrounding quotes.
    String value = _source.substring(_start + 1, _current - 1);
    addToken(TokenType.string, value);
  }

  String _peek() => _isAtEnd() ? '\0' : _source[_current];

  String _peekNext() {
    if (_current + 1 >= _source.length) return '\0';
    return _source[_current + 1];
  }

  bool _match(final String expectedToken){
    if (_isAtEnd()){ return false; }

    if(_source[_current] != expectedToken){ return false; }

    _current++;
    return true;
  }
}
