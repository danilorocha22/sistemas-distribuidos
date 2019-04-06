import java.util.List;

/**
 * Aplicação de exemplo de princípios de programação
 * funcional em Java, Expressões Lambda e API de Streams do Java 8.
 *
 * Para aprofundar nestes assuntos, veja os links abaixo:
 *
 * <ul>
 *     <li><a href="https://www.oracle.com/technetwork/pt/articles/java/streams-api-java-8-3410098-ptb.html">Curso Streams e Expressões Lambda do Java 8</a></li>
 *     <li><a href="https://apexapps.oracle.com/pls/apex/f?p=44785:145:0::::P145_EVENT_ID,P145_PREV_PAGE:4887,143">Curso JDK 8 MOOC: Lambdas and Streams Introduction</a></li>
 * </ul>
 *
 * @author Manoel Campos da Silva Filho
 */
public class AppProgramacaoFuncional {
    private static final int TOTAL_STUDENTS = 1000;
    private final List<Student> students;

    public AppProgramacaoFuncional(){
        students = StudentGenerator.generate(TOTAL_STUDENTS);
    }

    public static void main(String[] args) {
        AppProgramacaoFuncional app = new AppProgramacaoFuncional();
        app.printStudents();
    }

    private void printStudents(){
    }

}
