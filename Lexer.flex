package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espaco=[ ,\t,\r]+
%{
    public String lexeme;
%}
%%

/* Espaco em branco */
{espaco} {/*Ignore*/}

/* Comentarios */
("//" (.)*) {lexeme=yytext(); return Comentario;} 

/* Quebra linha */
( "\n" ) {lexeme=yytext(); return linha;}

/*Tipo*/
((("boolean" | "int" | "float" | "void")"[""]")|("boolean" | "int" | "float" | "void")) {lexeme=yytext(); return Tipo;}

/* Tipo de dato String */
( String ) {lexeme=yytext(); return cadeia;}

/* Palavra reservada If */
( if ) {lexeme=yytext(); return If;}

/* Palavra reservada Else */
( else ) {lexeme=yytext(); return Else;}

/* Palavra reservada Do */
( do ) {lexeme=yytext(); return Do;}

/* Palavra reservada While */
( while ) {lexeme=yytext(); return While;}

/* Palavra reservada For */
( for ) {lexeme=yytext(); return For;}

/* Operador Igual */
( "=" ) {lexeme=yytext(); return Igual;}

/* Operador Soma */
( "+" ) {lexeme=yytext(); return Soma;}

/* Operador Subtracao */
( "-" ) {lexeme=yytext(); return Subtracao;}

/* Operador Multiplicacao */
( "*" ) {lexeme=yytext(); return Multiplicacao;}

/* Operador Divisao */
( "/" ) {lexeme=yytext(); return Divisao;}

/* Operadores logicos */
( "&&" | "||" | "!" | "&" | "|" ) {lexeme=yytext(); return Op_Logico;}

/*Operadores Relacionais */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) {lexeme = yytext(); return Op_Relacional;}

/* Operadores Atrubuicao */
( "+=" | "-="  | "*=" | "/=" | "%=") {lexeme = yytext(); return Op_Atribuicao;}

/* Operadores Incremento e decremento */
( "++" | "--" ) {lexeme = yytext(); return Op_Incremento;}

/*Operadores Booleanos*/
(true | false)      {lexeme = yytext(); return Op_Booleano;}

/* Parenteses de abertura */
( "(" ) {lexeme=yytext(); return Parenteses_a;}

/* Parenteses de fechamento */
( ")" ) {lexeme=yytext(); return Parenteses_c;}

/* Chave de Abertura */
( "{" ) {lexeme=yytext(); return Chave_a;}

/* Chave de Fechamento */
( "}" ) {lexeme=yytext(); return Chave_c;}

/* Couchete abertura */
( "[" ) {lexeme = yytext(); return Couchete_a;}

/* Couchete de fechamento */
( "]" ) {lexeme = yytext(); return Couchete_c;}

/* Marcador de inicio do algoritmo */
( "main" ) {lexeme=yytext(); return Main;}

/* Ponto e virgula */
( ";" ) {lexeme=yytext(); return P_Virgula;}

/*Virgula*/
( "," ) {lexeme=yytext(); return Virgula;}

/*Palavras reservadas*/
("class" | "public" | "return" | "static" | "print" | "println" ) {lexeme=yytext(); return palavraReservada;}

/* Identificador */
{L}({L}|{D})* {lexeme=yytext(); return Identificador;}

/* Numero */
("(-"{D}+")")|{D}+ {lexeme=yytext(); return Numero;}

/*Funcoes para leitura*/
("readInt()" | "readFloat()" | "readLine()" | "readBoolean()") {lexeme=yytext(); return FuncaoLeitura;}

/*Const inteira*/
({D}+)  {lexeme=yytext(); return ConstInteira;}

/*Const real*/
({D}+"."{D}+)  {lexeme=yytext(); return ConstReal;}

/*Const String*/
(\"([^\\\"]|\\.)*\") {lexeme=yytext(); return ConstString;}

/* Error de analise */
 . {return ERROR;}
