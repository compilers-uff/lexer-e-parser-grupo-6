package chocopy.pa1;
import java_cup.runtime.*;
import java.util.Stack;

%%

/* Do not change the flags below unless you know what you are doing. */

%unicode
%line
%column

%class ChocoPyLexer
%public

%cupsym ChocoPyTokens
%cup
%cupdebug

%eofclose false

%state INDENT_CTRL ESTADO

/* Do not change the flags above unless you know what you are doing. */

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
    {pilha.push(0);}
    public int estado = 0;
    public String whitesp = "";
    public int leng = 0;
    public int qtde_whitesp = 0;
    public int qtde_tab = 0;

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

WhiteSpace = [ \t]*
LineBreak  = \r|\n|\r\n
Identifier = (_|[a-z]|[A-Z])(_|[a-z]|[A-Z]|[0-9])*
StringLiteral = \"[[^]--\"]*\"
IdString = \"(_|[a-z]|[A-Z])(_|[a-z]|[A-Z]|[0-9])*\"
IntegerLiteral = 0 | [1-9][0-9]*

%%

<YYINITIAL> {

  /* No início do programa, todo NEWLINE é descartado. O primeiro caracter do programa que não é uma quebra de linha leva o lexer ao seu estado principal. */
  
  {LineBreak}                 {}

  [^] {
    yypushback(1);
    yybegin(ESTADO);
  }

}

<ESTADO> {

  "#".*        { /* ignora comentários */ }

  /* Delimiters. */

  /* Sempre que ocorre uma quebra de linha no meio do programa, o lexer vai para o estado de controle de identação (onde são emitidos tokens INDENT e DEDENT) */
  {LineBreak}                 { yybegin(INDENT_CTRL);
                                                return symbol(ChocoPyTokens.NEWLINE); }


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

  /* Literals. */
  {IntegerLiteral}            { return symbol(ChocoPyTokens.NUMBER,
                                                 Integer.parseInt(yytext())); }
  {IdString}                  {return symbol(ChocoPyTokens.IDSTRING,yytext()); }
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


  /* Whitespace. */
  {WhiteSpace}                {}
}

<INDENT_CTRL> {

  /* Para chegar neste estado, necessariamente houve uma quebra de linha. Se outra quebra de linha é encontrada enquanto neste estado, é porque há ao menos duas quebras de linha seguidas. A linha de código abaixo ignora todos os NEWLINEs fora o primeiro(cujo token já foi emitido antes de entrar neste estado), pois não fazem diferença para o programa e dificultam a construção do lexer e do parser. */

  {LineBreak}                 {}

  /* Após a quebra de linha, espera-se encontrar 0 ou mais espaços em branco. O trecho abaixo recebe todos os espaços em branco de uma vez e analisa se é necessário emitir um token INDENT ou DEDENT, utilizando o esquema de pilha indicado pela documentação do ChocoPy. */

  {WhiteSpace} {
    this.whitesp = yytext();
    this.qtde_whitesp = 0;
    this.qtde_tab = 0;

    /* Conta a quantidade de espaços em branco propriamente ditos e de tabs e depois calcula o tamanho real do espaçamento, contando um tab como 8 espaços em branco. */
    for (int i = 0; i < whitesp.length(); i++) {
        char c = whitesp.charAt(i);
        if (c == ' ') qtde_whitesp++;
        else if (c == '\t') qtde_tab++;
    }

    this.leng = qtde_whitesp + 8 * qtde_tab;

    /* Se o espalo em branco é maior que o topo da pilha de identação, é necessário emitir um INDENT*/

    if (pilha.peek() < leng) {
        pilha.push(leng);
        yybegin(ESTADO);
        return symbol(ChocoPyTokens.INDENT, yytext());

    /* Se o espaço em branco é menor que o topo da pilha de identação, é necessário emitir um ou mais DEDENTs */

    } else if (pilha.peek() > leng) {
        pilha.pop();

        /* Se, após emitir um DEDENT e retirar o topo da pilha, o espaço em branco ainda for menor que o topo da pilha, o WhiteSpace é rebobinado e será feita mais uma iteração desse algoritmo. Após qualquer emissão de INDENT ou DEDENT (ou nenhuma emissão, caso não haja mudança na identação), volta-se para o estado ESTADO, menos nesse caso. Por isso esse algoritmo é repetido. */

        if (pilha.peek() > leng) {
            yypushback(yylength());
            return symbol(ChocoPyTokens.DEDENT);
        }
        yybegin(ESTADO);
        return symbol(ChocoPyTokens.DEDENT);
    }

    yybegin(ESTADO);
  }

  /* Se não houver qualquer espaço em branco no começo da linha, o lexer não vai cair no caso acima, mas ainda pode haver a necessidade de emitir DEDENTs. Nesse caso, a regra cai em qualquer caracter e executa um algoritmo similar ao descrito acima para emissão de DEDENTs, porém rebobinando sempre 1 caracter (o que foi consumido neste caso) */

  [^] {
    if (pilha.peek() > 0) {
        pilha.pop();
        if (pilha.peek() > 0) {
            yypushback(1);
            return symbol(ChocoPyTokens.DEDENT);
        }
        yypushback(1);
        yybegin(ESTADO);
        return symbol(ChocoPyTokens.DEDENT);
    }
    yybegin(ESTADO);
    yypushback(1); // volta o caractere que não é espaço
  }
}

/* Ao final do programa, pode ser que haja DEDENTs a serem emitidos, mas que não foram porque não houve quebra de linha depois da última linha. Por isso, são emitidos aqui todos os tokens DEDENT restantes. */
<<EOF>>                         { if (this.pilha.peek() > 0) {
                                  this.pilha.pop();
                                  return symbol(ChocoPyTokens.DEDENT);
                                }
                                return symbol(ChocoPyTokens.EOF); }
/* Error fallback. */
[^]                           { return symbol(ChocoPyTokens.UNRECOGNIZED); }