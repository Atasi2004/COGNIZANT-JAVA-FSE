package Exercise3;

public class Computer {
    // Required parameters
    private final String cpu;
    private final String ram;

    // Optional parameters
    private final String storage;
    private final String graphicsCard;

    // Private constructor
    private Computer(Builder builder) {
        this.cpu = builder.cpu;
        this.ram = builder.ram;
        this.storage = builder.storage;
        this.graphicsCard = builder.graphicsCard;
    }

    public String toString() {
        return "Computer [CPU=" + cpu + ", RAM=" + ram + ", Storage=" + storage + ", GraphicsCard=" + graphicsCard + "]";
    }

    // Static nested Builder class
    public static class Builder {
        private final String cpu;
        private final String ram;
        private String storage;
        private String graphicsCard;

        public Builder(String cpu, String ram) {
            this.cpu = cpu;
            this.ram = ram;
        }

        public Builder setStorage(String storage) {
            this.storage = storage;
            return this;
        }

        public Builder setGraphicsCard(String graphicsCard) {
            this.graphicsCard = graphicsCard;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }

    }
    public class Main {
    public static void main(String[] args) {
        // Computer with only required parts
        Computer basicComputer = new Computer.Builder("Intel i5", "8GB").build();
        System.out.println(basicComputer);

        // Computer with all parts
        Computer gamingComputer = new Computer.Builder("AMD Ryzen 9", "32GB")
                                        .setStorage("1TB SSD")
                                        .setGraphicsCard("NVIDIA RTX 4080")
                                        .build();
        System.out.println(gamingComputer);
    }
}
}
