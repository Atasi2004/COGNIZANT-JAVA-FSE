import java.util.concurrent.*;

public class CallableExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(3);

        Callable<String> task = () -> "Task Result";
        Future<String> future = executor.submit(task);

        System.out.println("Result: " + future.get());

        executor.shutdown();
    }
}
