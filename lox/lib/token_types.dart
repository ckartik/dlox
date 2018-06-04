enum TokenType {
  // single-character tokens.
  leftParen,
  rightParen,
  leftBrace,
  rightBrace,
  comma,
  dot,
  minus,
  plus,
  semicolon,
  slash,
  star,

  // one or two character tokens.
  bang,
  bangEqual,
  equal,
  equalEqual,
  greater,
  greaterEqual,
  less,
  lessEqual,

  // literals.
  identifier,
  string,
  number,

  // keywords.
  andKey,
  classKey,
  elseKey,
  falseKey,
  funKey,
  forKey,
  ifKey,
  nilKey,
  orKey,
  printKey,
  returnKey,
  superKey,
  thisKey,
  trueKey,
  varKey,
  whileKey,

  eof,
}
