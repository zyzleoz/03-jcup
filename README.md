# 03-jcup

1. Baixar o `JFlex`:
- `wget https://repo1.maven.org/maven2/de/jflex/jflex/1.8.2/jflex-1.8.2.jar -O jflex.jar`

2. Baixa o `JCup`:
- `wget https://repo1.maven.org/maven2/com/github/vbmacher/java-cup/11b-20160615/java-cup-11b-20160615.jar -O jcup.jar`

3. Criar o arquivo `exemplo.flex`:
- `touch exemplo.flex`

4. Informar o conteúdo do arquivo `exemplo.flex`:
```java
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
\n        { /* Ignora nova linha. */ }
[ \t\r]+  { /* Ignora espaços. */ }
.         { System.err.println("Caractere inválido: " + yytext()); return null; }
```

5. Criar o arquivo `exemplo.cup`:
- `touch exemplo.cup`

6. Informar o conteúdo do arquivo `exemplo.cup`:
```java
import java_cup.runtime.*;

terminal Integer INTEIRO;
terminal MAIS, MENOS, PTVIRG;

non terminal inicio;
non terminal Integer expr;

precedence left MAIS, MENOS;

start with inicio;

inicio ::= expr:e PTVIRG {: System.out.println(e); :}
         ;

expr ::= expr:a MAIS expr:b  {: RESULT = a.intValue() + b.intValue(); :}
       | expr:a MENOS expr:b {: RESULT = a.intValue() - b.intValue(); :}
       | INTEIRO:a {: RESULT = a.intValue(); :}
       ;
```

7. Criar o arquivo `Main.java`:
- `touch Main.java`

8. Informar o conteúdo do arquivo `Main.java`:
```java
import java.io.*;

public class Main {
  public static void main(String[] args) throws Exception {
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
    System.out.println("Digite expressões (termine com ';') e pressione ENTER. Ctrl+C para sair.");

    while (true) {
      System.out.print("> ");
      String linha = reader.readLine();

      if (linha == null || linha.trim().isEmpty()) continue;

      // Adicionar um \n no final para garantir que o analisador leia a linha completa:
      StringReader sr = new StringReader(linha + "\n");

      parser p = new parser(new Yylex(sr));
      try {
        p.parse();
      } catch (Exception e) {
        System.err.println("Erro na expressão: " + e.getMessage());
      }
    }
  }
}
```
9. Comando para o JFlex:
- `java -cp jflex.jar:jcup.jar jflex.Main exemplo.flex`

10. Comando para o JCup:
- `java -cp jcup.jar java_cup.Main exemplo.cup`

11. Comandos para compilar as classes .java:
- `javac -cp jcup.jar *.java`

12. Rodar a classe principal:
- `java -cp .:jcup.jar Main` 

13. Informe expressões matemáticas do tipo: 
- `1 + 2 - 7;` (é necessário terminar com ";")

- ```
  1 + 2
  - 7;
  ```
  (é necessário terminar com ";")

14. Excluir arquivos desnecessários: 
- `rm -rf *.class parser.java sym.java Yylex.java *.java~`