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

    _tokens.add(new Token(TokenType.EOF, Token.EOF, null, _line));
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
      case Token.BANG:
        addToken(match(Token.EQUAL) ? TokenType.BANG_EQUAL : TokenType.BANG);
        break;
      case Token.GREATER:
        addToken(match(Token.EQUAL) ? TokenType.GREATER_EQUAL : TokenType.GREATER);
        break;
      case Token.LESS:
        addToken(match(Token.EQUAL) ? TokenType.LESS_EQUAL: TokenType.LESS);
        break;
      case Token.EQUAL:
        addToken(match(Token.EQUAL) ? TokenType.EQUAL_EQUAL : TokenType.EQUAL);
        break;
      case Token.SLASH:
        if(match(Token.SLASH)){
          while (_peek() != Token.NEW_LINE && !_isAtEnd()) advance();
        }
        else addToken(TokenType.SLASH);
        break;
      case Token.NEW_LINE:
        _line++;
        break;
      case Token.SPACE:
        break;
      case Token.SPACE_R:
        break;
      case Token.SPACE_TAB:
        break;
      case Token.STRING:
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

    addToken(TokenType.NUMBER,
        double.parse(_source.substring(_start, _current)));
  }

  void _string(){
    while (_peek() != Token.STRING && !_isAtEnd()) {
      if (_peek() == Token.NEW_LINE) _line++;
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
    addToken(TokenType.STRING, value);
  }

  String _peek() => _isAtEnd() ? '\0' : _source[_current];

  String _peekNext() {
    if (_current + 1 >= _source.length) return '\0';
    return _source[_current + 1];
  }

  bool match(final String expectedToken){
    if (_isAtEnd()){ return false; }

    if(_source[_current] != expectedToken){ return false; }

    _current++;
    return true;
  }
}
