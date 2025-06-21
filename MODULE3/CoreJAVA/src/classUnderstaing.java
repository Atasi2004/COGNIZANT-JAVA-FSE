class Car{
    int make;
    int model;
    int year;
    Car(int make,int model,int year){
        this.make = make;
        this.model = model;
        this.year = year;
    }
    void displayDetails(){
        System.out.println("Make :"+make);
        System.out.println("Model :"+model);
        System.out.println("Year :"+year);
    }
}
public class classUnderstaing {
    public static void main(String[] args) {
        Car car = new Car(12,2000,25);
        car.displayDetails();
    }
}
