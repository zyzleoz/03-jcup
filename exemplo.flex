import java_cup.runtime.Symbol;

%%

%cup

digito = [0-9]
inteiro = {digito}+

%%

{inteiro} {
            Integer numero = Integer.valueOf(yytext());
            return new Symbol(sym.INTEIRO, yyline, yycolumn, numero);
          }
"+"       { return new Symbol(sym.MAIS); }
"-"       { return new Symbol(sym.MENOS); }
";"       { return new Symbol(sym.PTVIRG); }
"*"       { return new Symbol(sym.MULTP); }
"/"       { return new Symbol(sym.DIVIS); }
"%"       { return new Symbol(sym.RESTO); }
"^"       { return new Symbol(sym.POTEN); }
\n        { /* Ignora nova linha. */ }
[ \t\r]+  { /* Ignora espaços. */ }
.         { System.err.println("Caractere inválido: " + yytext()); return null; }
