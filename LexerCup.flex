package codigo;
import java_cup.runtime.Symbol;

%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
L=[a-zA-Z_]+
D=[0-9]+
espaco=[ ,\t,\r,\n]+

%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Espaco em branco */
{espaco} {/*Ignore*/}

/* Comentarios */
("//" (.)*) {return new Symbol(sym.Comentario, yychar, yyline, yytext());}

/*Tipo*/
((("boolean" | "int" | "float" | "void")"[""]")|("boolean" | "int" | "float" | "void")) {return new Symbol(sym.Tipo, yychar, yyline, yytext());}

/* Tipo de dato String */
( String ) {return new Symbol(sym.cadeia, yychar, yyline, yytext());}

/* Palavra reservada If */
( if ) {return new Symbol(sym.If, yychar, yyline, yytext());}

/* Palavra reservada Else */
( else ) {return new Symbol(sym.Else, yychar, yyline, yytext());}

/* Palavra reservada Do */
( do ) {return new Symbol(sym.Do, yychar, yyline, yytext());}

/* Palavra reservada While */
( while ) {return new Symbol(sym.While, yychar, yyline, yytext());}

/* Palavra reservada For */
( for ) {return new Symbol(sym.For, yychar, yyline, yytext());}

/* Operador Igual */
( "=" ) {return new Symbol(sym.Igual, yychar, yyline, yytext());}

/* Operador Soma */
( "+" ) {return new Symbol(sym.Soma, yychar, yyline, yytext());}

/* Operador Subtracao */
( "-" ) {return new Symbol(sym.Subtracao, yychar, yyline, yytext());}

/* Operador Multiplicacao */
( "*" ) {return new Symbol(sym.Multiplicacao, yychar, yyline, yytext());}

/* Operador Divisao */
( "/" ) {return new Symbol(sym.Divisao, yychar, yyline, yytext());}

/* Operadores logicos */
( "&&" | "||" | "!" | "&" | "|" ) {return new Symbol(sym.Op_Logico, yychar, yyline, yytext());}

/*Operadores Relacionais */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) {return new Symbol(sym.Op_Relacional, yychar, yyline, yytext());}

/* Operadores Atrubuicao */
( "+=" | "-="  | "*=" | "/=" | "%="| "=" ) {return new Symbol(sym.Op_Atribuicao, yychar, yyline, yytext());}

/* Operadores Incremento e decremento */
( "++" | "--" ) {return new Symbol(sym.Op_Incremento, yychar, yyline, yytext());}

/*Operadores Booleanos*/
(true | false)     {return new Symbol(sym.Op_Booleano, yychar, yyline, yytext());}

/* Parenteses de abertura */
( "(" ) {return new Symbol(sym.Parenteses_a, yychar, yyline, yytext());}

/* Parenteses de fechamento */
( ")" ) {return new Symbol(sym.Parenteses_c, yychar, yyline, yytext());}

/* Chave de Abertura */
( "{" ) {return new Symbol(sym.Chave_a, yychar, yyline, yytext());}

/* Chave de Fechamento */
( "}" ) {return new Symbol(sym.Chave_c, yychar, yyline, yytext());}

/* Couchete abertura */
( "[" ) {return new Symbol(sym.Couchete_a, yychar, yyline, yytext());}

/* Couchete de fechamento */
( "]" ) {return new Symbol(sym.Couchete_c, yychar, yyline, yytext());}

/* Marcador de inicio do algoritmo */
( "main" ) {return new Symbol(sym.Main, yychar, yyline, yytext());}

/* Ponto e virgula */
( ";" ) {return new Symbol(sym.P_Virgula, yychar, yyline, yytext());}

/*Virgula*/
( "," ) {return new Symbol(sym.Virgula, yychar, yyline, yytext());}

/*Palavras reservadas*/
("class" | "public" | "return" | "static" | "print" | "println" ) {return new Symbol(sym.palavraReservada, yychar, yyline, yytext());}

/* Identificador */
{L}({L}|{D})* {return new Symbol(sym.Identificador, yychar, yyline, yytext());}

/* Numero */
("(-"{D}+")")|{D}+ {return new Symbol(sym.Numero, yychar, yyline, yytext());}

/*Funcoes para leitura*/
("readInt()" | "readFloat()" | "readLine()" | "readBoolean()") {return new Symbol(sym.FuncaoLeitura, yychar, yyline, yytext());}

/*Const inteira*/
({D}+)  {return new Symbol(sym.ConstInteira, yychar, yyline, yytext());}

/*Const real*/
({D}+"."{D}+)  {return new Symbol(sym.ConstReal, yychar, yyline, yytext());}

/*Const String*/
(\"([^\\\"]|\\.)*\") {return new Symbol(sym.ConstString, yychar, yyline, yytext());}

/* Error de analise */
 . {return new Symbol(sym.ERROR, yychar, yyline, yytext());}