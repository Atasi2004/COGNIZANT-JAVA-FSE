package Algorithm_Data_Structures.TaskManagementSystem;

public class Main {
    public static void main(String[] args) {
        TaskManager manager = new TaskManager();

        manager.addTask(new Task(1, "Design Database", "Pending"));
        manager.addTask(new Task(2, "Write APIs", "In Progress"));
        manager.addTask(new Task(3, "Deploy App", "Pending"));

        System.out.println("All Tasks:");
        manager.traverseTasks();

        System.out.println("\nSearching for Task ID 2:");
        Task t = manager.searchTask(2);
        System.out.println(t != null ? t : "Not Found");

        System.out.println("\nDeleting Task ID 1...");
        manager.deleteTask(1);

        System.out.println("\nTasks after deletion:");
        manager.traverseTasks();
    }
}
