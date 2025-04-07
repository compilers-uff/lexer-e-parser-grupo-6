package chocopy.pa1;
import java_cup.runtime.*;

%%

/*** Do not change the flags below unless you know what you are doing. ***/

%unicode
%line
%column

%class ChocoPyLexer
%public

%cupsym ChocoPyTokens
%cup
%cupdebug

%eofclose false

/*** Do not change the flags above unless you know what you are doing. ***/

/* The following code section is copied verbatim to the
 * generated lexer class. */
%{
    /* The code below includes some convenience methods to create tokens
     * of a given type and optionally a value that the CUP parser can
     * understand. Specifically, a lot of the logic below deals with
     * embedded information about where in the source code a given token
     * was recognized, so that the parser can report errors accurately.
     * (It need not be modified for this project.) */

    /** Producer of token-related values for the parser. */
    final ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();
    public Stack<Integer> pilha = new Stack<>();
    pilha.push(0)
    public int state = 0;
    public String whitesp = "";
    public int leng = 0;
    public int ws = 0;
    public int ts = 0;

    /** Return a terminal symbol of syntactic category TYPE and no
     *  semantic value at the current source location. */
    private Symbol symbol(int type) {
        return symbol(type, yytext());
    }

    /** Return a terminal symbol of syntactic category TYPE and semantic
     *  value VALUE at the current source location. */
    private Symbol symbol(int type, Object value) {
        return symbolFactory.newSymbol(ChocoPyTokens.terminalNames[type], type,
            new ComplexSymbolFactory.Location(yyline + 1, yycolumn + 1),
            new ComplexSymbolFactory.Location(yyline + 1,yycolumn + yylength()),
            value);
    }

%}

/* Macros (regexes used in rules below) */

WhiteSpace = [ \t]
LineBreak  = \r|\n|\r\n
Identifier = (_|[a-z]|[A-Z])(_|[a-z]|[A-Z]|[0-9])*
StringLiteral = \"[^]*\"
IntegerLiteral = 0 | [1-9][0-9]*

%%


<YYINITIAL> {

  /* Delimiters. */
  {LineBreak}                 { if (this.state == 0){this.state = 1;}
                                                return symbol(ChocoPyTokens.NEWLINE); }

  /* Literals. */
  {IntegerLiteral}            { return symbol(ChocoPyTokens.NUMBER,
                                                 Integer.parseInt(yytext())); }
  {StringLiteral}             { return symbol(ChocoPyTokens.STRING, yytext()); }
    /* Identifier. */
    {Identifier}                { return symbol(ChocoPyTokens.IDENTIFIER, yytext()); }

/* Operators. */
  "->"                        { return symbol(ChocoPyTokens.ARROW, yytext()); }
  "+"                         { return symbol(ChocoPyTokens.PLUS, yytext()); }
  "-"                         { return symbol(ChocoPyTokens.MINUS, yytext()); }
  "*"                         { return symbol(ChocoPyTokens.TIMES, yytext()); }
  "//"                        { return symbol(ChocoPyTokens.FLOORDIV, yytext()); }
  "%"                         { return symbol(ChocoPyTokens.MOD, yytext()); }
  "<="                        { return symbol(ChocoPyTokens.LE, yytext()); }
  ">="                        { return symbol(ChocoPyTokens.GE, yytext()); }
  "=="                        { return symbol(ChocoPyTokens.EQ, yytext()); }
  "!="                        { return symbol(ChocoPyTokens.NE, yytext()); }
  "<"                         { return symbol(ChocoPyTokens.LT, yytext()); }
  ">"                         { return symbol(ChocoPyTokens.GT, yytext()); }
  "="                         { return symbol(ChocoPyTokens.ASSIGN, yytext()); }
  "("                         { return symbol(ChocoPyTokens.LPAREN, yytext()); }
  ")"                         { return symbol(ChocoPyTokens.RPAREN, yytext()); }
  "["                         { return symbol(ChocoPyTokens.LBRACKET, yytext()); }
  "]"                         { return symbol(ChocoPyTokens.RBRACKET, yytext()); }
  ","                         { return symbol(ChocoPyTokens.COMMA, yytext()); }
  ":"                         { return symbol(ChocoPyTokens.COLON, yytext()); }
  "."                         { return symbol(ChocoPyTokens.DOT, yytext()); }

  /* Keywords. */
  "False"   { return symbol(ChocoPyTokens.FALSE, false); }
  "None"    { return symbol(ChocoPyTokens.NONE, yytext()); }
  "True"    { return symbol(ChocoPyTokens.TRUE, true); }
  "and"     { return symbol(ChocoPyTokens.AND, yytext()); }
  "as"      { return symbol(ChocoPyTokens.AS, yytext()); }
  "assert"  { return symbol(ChocoPyTokens.ASSERT, yytext()); }
  "async"   { return symbol(ChocoPyTokens.ASYNC, yytext()); }
  "await"   { return symbol(ChocoPyTokens.AWAIT, yytext()); }
  "break"   { return symbol(ChocoPyTokens.BREAK, yytext()); }
  "class"   { return symbol(ChocoPyTokens.CLASS, yytext()); }
  "continue" { return symbol(ChocoPyTokens.CONTINUE, yytext()); }
  "def"     { return symbol(ChocoPyTokens.DEF, yytext()); }
  "del"     { return symbol(ChocoPyTokens.DEL, yytext()); }
  "elif"    { return symbol(ChocoPyTokens.ELIF, yytext()); }
  "else"    { return symbol(ChocoPyTokens.ELSE, yytext()); }
  "except"  { return symbol(ChocoPyTokens.EXCEPT, yytext()); }
  "finally" { return symbol(ChocoPyTokens.FINALLY, yytext()); }
  "for"     { return symbol(ChocoPyTokens.FOR, yytext()); }
  "from"    { return symbol(ChocoPyTokens.FROM, yytext()); }
  "global"  { return symbol(ChocoPyTokens.GLOBAL, yytext()); }
  "if"      { return symbol(ChocoPyTokens.IF, yytext()); }
  "import"  { return symbol(ChocoPyTokens.IMPORT, yytext()); }
  "in"      { return symbol(ChocoPyTokens.IN, yytext()); }
  "is"      { return symbol(ChocoPyTokens.IS, yytext()); }
  "lambda"  { return symbol(ChocoPyTokens.LAMBDA, yytext()); }
  "nonlocal" { return symbol(ChocoPyTokens.NONLOCAL, yytext()); }
  "not"     { return symbol(ChocoPyTokens.NOT, yytext()); }
  "or"      { return symbol(ChocoPyTokens.OR, yytext()); }
  "pass"    { return symbol(ChocoPyTokens.PASS, yytext()); }
  "raise"   { return symbol(ChocoPyTokens.RAISE, yytext()); }
  "return"  { return symbol(ChocoPyTokens.RETURN, yytext()); }
  "try"     { return symbol(ChocoPyTokens.TRY, yytext()); }
  "while"   { return symbol(ChocoPyTokens.WHILE, yytext()); }
  "with"    { return symbol(ChocoPyTokens.WITH, yytext()); }
  "yield"   { return symbol(ChocoPyTokens.YIELD, yytext()); }

  /* Whitespace. */
  {WhiteSpace}                { if (this.state == 1) {
                                                        this.whitesp = yytext();
                                                        this.leng = whitesp.lenght();
                                                        this.ws = 0;
                                                        this.ts = 0;
                                                        for (int i = 0; i < whitesp.length(); i++){
                                                            char c = whitesp.charAt(i);        
                                                            if (c.equals(' ')) {
                                                              ws++;
                                                            } else {
                                                              ts++;
                                                            }
                                                        }
                                                        this.leng = ws + 8*ts;
                                                        
                                                        if (this.pilha.peek() < this.leng) {
                                                            this.pilha.push(this.leng);
                                                            this.state = 0;
                                                            return symbol(ChocoPyTokens.INDENT);
                                                        }
                                                        else {
                                                            if (this.pilha.peek() > this.leng) {
                                                                this.pilha.pop();
                                                                if (this.pilha.peek() > this.leng) {
                                                                  yypushback(yylength())
                                                                  return symbol(ChocoPyTokens.DEDENT);
                                                                } 
                                                                this.state = 0;
                                                                return symbol(ChocoPyTokens.DEDENT);
                                                            }
                                                        }
                                                        
                                                    } }
}

<<EOF>>                       { return symbol(ChocoPyTokens.EOF); }

/* Error fallback. */
[^]                           { return symbol(ChocoPyTokens.UNRECOGNIZED); }
