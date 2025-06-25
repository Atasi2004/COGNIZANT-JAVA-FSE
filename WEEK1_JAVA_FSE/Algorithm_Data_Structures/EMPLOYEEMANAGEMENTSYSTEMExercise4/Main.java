package Algorithm_Data_Structures.EMPLOYEEMANAGEMENTSYSTEMExercise4;

public class Main {
    public static void main(String[] args) {
        EmployeeManager manager = new EmployeeManager(5);

        Employee e1 = new Employee(1, "Alice", "Manager", 75000);
        Employee e2 = new Employee(2, "Bob", "Engineer", 55000);
        Employee e3 = new Employee(3, "Clara", "Designer", 60000);

        manager.addEmployee(e1);
        manager.addEmployee(e2);
        manager.addEmployee(e3);

        System.out.println("All Employees:");
        manager.traverseEmployees();

        System.out.println("\nSearching for Employee ID 2:");
        Employee result = manager.searchEmployee(2);
        System.out.println(result != null ? result : "Not Found");

        System.out.println("\nDeleting Employee ID 2:");
        manager.deleteEmployee(2);

        System.out.println("\nEmployees after deletion:");
        manager.traverseEmployees();
    }
}
