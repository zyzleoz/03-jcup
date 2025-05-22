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